//
//  StopRunResponse.swift
//  InducedMini
//
//  Created by Aayush Pokharel on 2024-03-22.
//

import Foundation

/// `StopRunResponse` is returned when /autonomous/{id}/stop is called.
public struct StopRunResponse: Codable {
    let success: Bool
    let requestId: String
    let timeTaken: Int
}
