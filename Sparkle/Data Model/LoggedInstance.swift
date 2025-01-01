//
//  LoggedEvent.swift
//  Sparkle
//
//  Created by Leon Rinkel on 30.12.24.
//

import Foundation
import SwiftData

@Model class LoggedInstance {

    var event: TrackedEvent?

    var timestamp: Date

    init(event: TrackedEvent, timestamp: Date = .now) {
        self.event = event
        self.timestamp = timestamp
    }

}

extension LoggedInstance {
    
    static var previewInstances: [LoggedInstance] {
        [
            .init(event: .previewEvents[0], timestamp: Date(timeIntervalSince1970: 1735598803)),
            .init(event: .previewEvents[0], timestamp: Date(timeIntervalSince1970: 1735598803-86400)),
            .init(event: .previewEvents[0], timestamp: Date(timeIntervalSince1970: 1735598803-86400*2)),
        ]
    }
    
}
