//
//  EventListItem.swift
//  Sparkle
//
//  Created by Leon Rinkel on 30.12.24.
//

import SwiftUI
import SwiftData

struct EventListItem: View {
    
    var event: TrackedEvent
    
    var body: some View {
        NavigationLink(value: event) {
            HStack {
                Circle()
                    .fill(Color(event.color).gradient)
                    .frame(width: 64, height: 64)
                    .overlay {
                        Text(String(event.emoji.first!))
                            .font(.system(size: 32))
                    }
                VStack(alignment: .leading) {
                    Text(event.title)
                        .font(.headline)
                    Text("\(event.loggedInstances.count) times logged")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
    
}

#Preview(traits: .sampleData) {
    @Previewable @Query var events: [TrackedEvent]
    List {
        EventListItem(event: events[0])
        EventListItem(event: events[1])
    }
}
