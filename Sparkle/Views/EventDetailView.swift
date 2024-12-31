//
//  EventDetailView.swift
//  Sparkle
//
//  Created by Leon Rinkel on 30.12.24.
//

import SwiftUI
import SwiftData

struct EventDetailView: View {
    
    @Environment(\.modelContext) private var modelContext

    var event: TrackedEvent
    
    var body: some View {
        InstanceListView(event: event)
        .navigationTitle(Text(event.title))
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Log", systemImage: "plus") {
                    logInstance()
                }
            }
        }
    }

    private func logInstance() {
        withAnimation {
            let newInstance = LoggedInstance(event: event)
            modelContext.insert(newInstance)
            event.loggedInstances.append(newInstance)
        }
    }
    
}

#Preview(traits: .sampleData) {
    @Previewable @Query var events: [TrackedEvent]
    EventDetailView(event: events[0])
}
