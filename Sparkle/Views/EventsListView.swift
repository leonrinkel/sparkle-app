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
    
    init(order: EventsSortOrder, selection: Binding<TrackedEvent?>, eventCount: Binding<Int>, searchText: String) {
        _selection = selection
        _eventCount = eventCount

        let predicate = #Predicate<TrackedEvent> {
            searchText.isEmpty ? true : $0.title.contains(searchText)
        }

        switch order.listBy {
        case .dateAdded:
            switch order.dateAddedOrder {
            case .newestFirst:
                _events = Query(filter: predicate, sort: \TrackedEvent.addedAt, order: .reverse)
            case .oldestFirst:
                _events = Query(filter: predicate, sort: \TrackedEvent.addedAt, order: .forward)
            }
        case .title:
            switch order.titleOrder {
            case .ascending:
                _events = Query(filter: predicate, sort: \TrackedEvent.title, order: .forward)
            case .descending:
                _events = Query(filter: predicate, sort: \TrackedEvent.title, order: .reverse)
            }
        }
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
                    Label("No Events", systemImage: "list.bullet.circle")
                } description: {
                    Text("Tap the plus button at the top to create a new event to track.")
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
