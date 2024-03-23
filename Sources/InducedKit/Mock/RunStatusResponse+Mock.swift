//
//  File.swift
//
//
//  Created by Aayush Pokharel on 2024-03-23.
//

import Foundation

public extension RunStatusResponse {
    static let example = RunStatusResponse(
        success: true,
        data: RunData(
            run: .init(
                id: "browser_3svorvFpxJwsMCs",
                status: "IDLE",
                objective: "Navigate to the Google website, find the stock information, and display the current stock price.",
                steps: [
                    .init(
                        id: "step_IMJz4FvDr2nDDMs",
                        step: "Navigate to google.com",
                        status: .queued,
                        thought: "Initiating navigation to Google"
                    )
                ],
                result: nil
            )
        ),
        requestId: "957d90f1-07db-463e-ae55-299a14a99af6",
        timeTaken: 46
    )
}
