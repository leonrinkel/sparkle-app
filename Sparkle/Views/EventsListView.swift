//
//  TypesListView.swift
//  Sparkle
//
//  Created by Leon Rinkel on 30.12.24.
//

import SwiftUI
import SwiftData

struct EventsListView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query var events: [TrackedEvent]
    
    @Binding var selection: TrackedEvent?
    @Binding var eventCount: Int
    
    init(selection: Binding<TrackedEvent?>, eventCount: Binding<Int>, searchText: String) {
        _selection = selection
        _eventCount = eventCount

        let predicate = #Predicate<TrackedEvent> {
            searchText.isEmpty ? true : $0.title.contains(searchText)
        }
        _events = Query(filter: predicate, sort: \TrackedEvent.addedAt)
    }
    
    var body: some View {
        List(selection: $selection) {
            ForEach(events) { event in
                EventListItem(event: event)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            deleteEvent(event)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
            .onDelete(perform: deleteEvents(at:))
        }
        .overlay {
            if events.isEmpty {
                ContentUnavailableView {
                    Label("No Events", systemImage: "car.circle")
                } description: {
                    Text("New events will appear here as soon as they are logged.")
                }
            }
        }
        .navigationTitle("Events")
        .onChange(of: events) { eventCount = events.count }
        .onAppear { eventCount = events.count }
    }
    
    private func deleteEvents(at offsets: IndexSet) {
        withAnimation {
            offsets.map { events[$0] }.forEach(deleteEvent)
        }
    }
    
    private func deleteEvent(_ event: TrackedEvent) {
        if event.persistentModelID == selection?.persistentModelID {
            selection = nil
        }
        modelContext.delete(event)
    }
    
}
