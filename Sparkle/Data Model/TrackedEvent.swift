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
    
    @Attribute(.transformable(by: UIColorValueTransformer.self))
    var color: UIColor = UIColor.lightGray

    var emoji: String

    var title: String

    var addedAt: Date = Date.now

    @Relationship(deleteRule: .cascade, inverse: \LoggedInstance.event)
    var loggedInstances: [LoggedInstance] = [LoggedInstance]()

    init(color: UIColor, emoji: String, title: String, addedAt: Date, loggedInstances: [LoggedInstance]) {
        self.color = color
        self.emoji = emoji
        self.title = title
        self.addedAt = addedAt
        self.loggedInstances = loggedInstances
    }
    
}

extension TrackedEvent {

    static var previewEvents: [TrackedEvent] {
        [
            .init(color: .lightGray, emoji: "🍕", title: "Ate Pizza", addedAt: .now, loggedInstances: []),
            .init(color: .lightGray, emoji: "🏢", title: "Went to the Office", addedAt: .now, loggedInstances: []),
        ]
    }

}
