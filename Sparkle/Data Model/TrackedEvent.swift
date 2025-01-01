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
    var uiColor: UIColor = UIColor.lightGray
    
    var color: Color {
        get {
            Color(uiColor)
        }
        set {
            uiColor = UIColor(newValue)
        }
    }

    var emoji: String

    var title: String

    var addedAt: Date

    @Relationship(deleteRule: .cascade, inverse: \LoggedInstance.event)
    var loggedInstances: [LoggedInstance]

    init(color: Color, emoji: String, title: String, addedAt: Date, loggedInstances: [LoggedInstance]) {
        self.emoji = emoji
        self.title = title
        self.addedAt = addedAt
        self.loggedInstances = loggedInstances
        self.color = color
    }
    
    init(from draft: TrackedEvent.Draft) {
        self.emoji = draft.emoji
        self.title = draft.title
        self.addedAt = Date.now
        self.loggedInstances = []
        self.color = draft.color
    }
    
}

extension TrackedEvent {

    static var previewEvents: [TrackedEvent] {
        [
            .init(color: .orange, emoji: "🍕", title: "Ate Pizza", addedAt: .now, loggedInstances: []),
            .init(color: .blue, emoji: "🏢", title: "Went to the Office", addedAt: .now, loggedInstances: []),
        ]
    }

}

extension TrackedEvent {
    
    @Observable class Draft {
        
        var color: Color
        var emoji: String
        var title: String
        
        var isValid: Bool {
            !emoji.isEmpty && !title.isEmpty
        }
        
        init(color: Color, emoji: String, title: String) {
            self.color = color
            self.emoji = emoji
            self.title = title
        }
        
        static func from(_ trackedEvent: TrackedEvent) -> Draft {
            return .init(color: trackedEvent.color, emoji: trackedEvent.emoji, title: trackedEvent.title)
        }
        
        static let empty: Draft = .init(color: .gray, emoji: "", title: "")
        
    }
    
}
