//
//  WebsocketVM.swift
//  InducedMini
//
//  Created by Aayush Pokharel on 2024-03-08.
//

import Foundation
import os.log
import SwiftUI

#if os(macOS)
public typealias SocketImage = NSImage
#elseif os(iOS) || os(watchOS)
public typealias SocketImage = UIImage
#endif

/// ViewModel for managing WebSocket connection and data.
@Observable
public class InducedVM {
    // MARK: - Properties

    private var webSocketTask: URLSessionWebSocketTask?
    private var browserID: String?
    private let apiKey: String!
    private let logger = Logger(subsystem: "com.inducedmini.websocketvm", category: "networking")

    public var image: SocketImage?
    public var connected: Bool = false
    public var loading: Bool = false
    public var stepsResponse: RunStatusResponse.RunData? = .none

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    // MARK: - Initializer

    /// Initializes the ViewModel with the necessary API key.
    /// - Parameter apiKey: The API key used for authentication with the server.
    public init(apiKey: String) {
        self.apiKey = apiKey
        logger.debug("InducedVM initialized with API key.")
    }

    /// Mock Init
    public init(mockData: Bool) {
        logger.warning("Mock data mode enabled")
        self.apiKey = ""
        self.connected = true
        self.loading = false
        self.image = .init(data: try! Data(contentsOf: .init(string: "https://wallpaperset.com/w/full/7/3/8/29781.jpg")!))
        self.stepsResponse = RunStatusResponse.example.data
    }

    // MARK: - Lifecycle Methods

    /// Prepares the ViewModel for a new session.
    public func newSession() {
        disconnectWebsocket()
        browserID = nil

        loading = false
        stepsResponse = nil
        image = nil

        logger.info("Session reset completed.")
    }

    // MARK: - API Methods

    /// Initiates a browsing session with the given search term.
    /// - Parameter searchTerm: The term to search for.
    public func browseForMe(searchTerm: String) async {
        loading = true
        logger.info("Starting browsing session for term: \(searchTerm).")

        var request = URLRequest(url: Constants.autonomousAPIURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")

        let requestBody = RequestBody(task: searchTerm)
        do {
            request.httpBody = try encoder.encode(requestBody)
        } catch {
            logger.error("Error serializing request body: \(error.localizedDescription)")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try decoder.decode(ApiResponse.self, from: data)

            browserID = response.data.id
            if let id = response.data.streamID { connect(id: id) }

            loading = false
            logger.info("Session started with ID: \(response.data.id).")
            await fetchRunStatus()

        } catch {
            logger.error("Failed to start session: \(error.localizedDescription)")
        }
    }

    /// Fetches the run status of the current browsing session.
    @MainActor
    public func fetchRunStatus() async {
        guard let browserID else {
            logger.error("Browser ID is not available yet.")
            return
        }

        logger.info("Fetching run status for ID: \(browserID).")

        guard let url = Constants.runStatusURL(browserID) else {
            logger.error("Invalid URL for fetching run status.")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "x-api-key")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let response = try? decoder.decode(RunStatusResponse.self, from: data) {
                stepsResponse = response.data
            } else {
                logger.error("Error decoding run status response as string: \(data)")
            }
        } catch {
            logger.error("Error fetching run status: \(error.localizedDescription)")
        }
    }
}

// MARK: - WebSocket Methods

extension InducedVM {
    /// Establishes a WebSocket connection using the given ID.
    /// - Parameter id: The ID used to form the WebSocket URL.
    private func connect(id: String) {
        guard let url = Constants.websocketURL(id) else {
            logger.error("Invalid WebSocket URL.")
            return
        }

        let urlSession = URLSession(configuration: .default)
        webSocketTask = urlSession.webSocketTask(with: url)
        webSocketTask?.resume()
        listen()

        logger.info("WebSocket connection initiated for ID: \(id).")
    }

    /// disconnectWebsockets the current WebSocket session.
    private func disconnectWebsocket() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
        connected = false

        logger.info("WebSocket disconnectWebsocketed.")
    }

    // MARK: - Private Methods

    /// Listens for incoming WebSocket messages.
    private func listen() {
        connected = true
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                self?.logger.error("WebSocket receiving error: \(error.localizedDescription)")
            case .success(let message):
                switch message {
                case .string(let text):
                    self?.handleTextMessage(text)
                default:
                    break
                }
                self?.listen()
            }
        }
    }

    /// Handles text messages received through the WebSocket.
    /// - Parameter text: The text message received.
    private func handleTextMessage(_ text: String) {
        if let data = text.data(using: .utf8),
           let decodedData = try? decoder.decode(WebsocketResponse.self, from: data),
           let imageData = Data(base64Encoded: decodedData.data)
        {
            #if os(macOS)
            image = NSImage(data: imageData)
            #else
            image = UIImage(data: imageData)
            #endif
        } else {
            logger.error("Failed to decode the received message: \(text)")
        }
    }
}

// MARK: Miscellaneous structs

extension InducedVM {
    // Websocket response
    struct WebsocketResponse: Codable {
        let event: String
        let data: String
    }

    // Browse for me takes a body with `task` instead of query.
    struct RequestBody: Codable {
        var task: String
    }
}
