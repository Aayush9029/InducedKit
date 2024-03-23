//
//  RunStatusResponse.swift
//  InducedMini
//
//  Created by Aayush Pokharel on 2024-03-22.
//

import Foundation

/// `RunStatusResponse` Represents the response from a run status API call.
public struct RunStatusResponse: Codable {
    /// Indicates if the API call was successful.
    public let success: Bool
    
    /// Contains the main data of the response.
    public let data: RunData
    
    /// A unique identifier for the request.
    public let requestId: String
    
    /// The time taken for the API call to complete, in milliseconds.
    public let timeTaken: Int

    /// `RunData` Represents the detailed data of the run.
    public struct RunData: Codable {
        /// Contains the details of the run.
        public let run: RunDetail
        
        /// `RunDetail` Provides details about the run, including its current state and steps.
        public struct RunDetail: Codable {
            /// The unique identifier of the run.
            public let id: String
            
            /// The current status of the run.
            public let status: String
            
            /// The objective of the run, describing what the run aims to achieve.
            public let objective: String?
            
            /// A list of steps that have been or will be executed in the run.
            public let steps: [Step]
            
            /// The result of the run, which may be `null` if the run has not yet completed.
            public let result: String?
            
            /// `Step` Represents a single step in the run, detailing its execution and outcome.
            public struct Step: Identifiable, Codable {
                /// The unique identifier of the step.
                public let id: String
                
                /// The action or command represented by the step.
                public let step: String
                
                /// The status of the step, indicating whether it has been completed, is in progress, or has yet to start.
                public let status: RunStatus
                
                /// The thought process or reasoning behind the step, which may be `null` if not applicable.
                public let thought: String?
                
                /// Status of the run
                public enum RunStatus: String, Codable {
                    case queued = "QUEUED"
                    case running = "RUNNING"
                    case success = "SUCCESS"
                    case failed = "FAILED"
                    case idle = "IDLE"
                }
            }
        }
    }
}
