//
//  EventType.swift
//  Sparkle
//
//  Created by Leon Rinkel on 30.12.24.
//

import Foundation
import SwiftData
import SwiftUI

@Model class TrackedEvent {

    #Index<TrackedEvent>([\.title])
    #Unique<TrackedEvent>([\.title])
    
    @Attribute(.preserveValueOnDeletion)
    var emoji: String

    @Attribute(.preserveValueOnDeletion)
    var title: String
    
    @Attribute(.preserveValueOnDeletion)
    var addedAt: Date

    @Relationship(deleteRule: .cascade, inverse: \LoggedInstance.event)
    var loggedInstances: [LoggedInstance] = [LoggedInstance]()

    init(emoji: String, title: String) {
        self.emoji = emoji
        self.title = title
        self.addedAt = Date.now
    }

}

extension TrackedEvent {

    static var previewEvents: [TrackedEvent] {
        [
            .init(emoji: "🍕", title: "Ate Pizza"),
            .init(emoji: "🏢", title: "Went to the Office"),
        ]
    }

}
