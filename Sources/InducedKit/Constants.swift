//
//  Constants.swift
//  InducedMini
//
//  Created by Aayush Pokharel on 2024-03-22.
//

import Foundation

enum Constants {
    static let base = "https://api.induced.ai/api/v1"

    static let autonomousAPIURL = URL(string: "\(base)/autonomous")!

    static func runStatusURL(_ browserID: String) -> URL? {
        return URL(string: "\(base)/autonomous/\(browserID)")!
    }

    static func websocketURL(_ id: String) -> URL? {
        URL(string: "wss://\(id.lowercased()).chromebrowser.stream")
    }

    static func endBrowserSessionURL(_ browserID: String) -> URL? {
        return URL(string: "\(base)/autonomous/\(browserID)/stop")
    }
}
