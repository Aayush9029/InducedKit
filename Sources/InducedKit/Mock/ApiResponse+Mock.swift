//
//  File.swift
//
//
//  Created by Aayush Pokharel on 2024-03-23.
//

import Foundation

extension ApiResponse {
    static let example = ApiResponse(
        success: true,
        data: ResponseData(
            id: "browser_xyZ123",
            streamingUrl: "https://streaming-client.induced.ai?id=zrMwLCI",
            watchUrl: "https://watch.induced.ai/watch/browser_xyZ123"
        ),
        requestId: "req_67890",
        timeTaken: 562
    )
}
