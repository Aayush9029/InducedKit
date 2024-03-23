//
//  APIResponse.swift
//  InducedMini
//
//  Created by Aayush Pokharel on 2024-03-22.
//

import Foundation

/// `ApiResponse` represents the response when /autonomous is called with auth and query (question) as the body.
public struct ApiResponse: Codable {
    let success: Bool
    let data: ResponseData
    let requestId: String
    let timeTaken: Int

    /// `ResponseData` contains valuable data about the executed run.
    struct ResponseData: Identifiable, Codable {
        let id: String
        let streamingUrl: String
        let watchUrl: String

        /// Computed property to extract the stream ID from the streamingUrl
        var streamID: String? {
            URLComponents(string: streamingUrl)?.queryItems?.first(where: { $0.name == "id" })?.value
        }
    }
}
