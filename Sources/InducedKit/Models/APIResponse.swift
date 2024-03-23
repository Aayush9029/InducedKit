//
//  APIResponse.swift
//  InducedMini
//
//  Created by Aayush Pokharel on 2024-03-22.
//

import Foundation

/// `ApiResponse` represents the response when /autonomous is called with auth and query (question) as the body.
public struct ApiResponse: Codable {
    public let success: Bool
    public let data: ResponseData
    public let requestId: String
    public let timeTaken: Int

    /// `ResponseData` contains valuable data about the executed run.
    public struct ResponseData: Identifiable, Codable {
        public let id: String
        public let streamingUrl: String
        public let watchUrl: String

        /// Computed property to extract the stream ID from the streamingUrl
        public var streamID: String? {
            URLComponents(string: streamingUrl)?.queryItems?.first(where: { $0.name == "id" })?.value
        }
    }
}
