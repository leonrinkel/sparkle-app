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
    
    @Query var allEvents: [TrackedEvent]

    private var pinnedEvents: [TrackedEvent] { allEvents.filter(\.pinned) }
    
    @Binding var selection: TrackedEvent?
    @Binding var eventCount: Int
    
    @State private var isPinnedSectionExpanded: Bool = true
    @State private var isAllSectionExpanded: Bool = true
    
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
                _allEvents = Query(filter: predicate, sort: \TrackedEvent.addedAt, order: .reverse)
            case .oldestFirst:
                _allEvents = Query(filter: predicate, sort: \TrackedEvent.addedAt, order: .forward)
            }
        case .title:
            switch order.titleOrder {
            case .ascending:
                _allEvents = Query(filter: predicate, sort: \TrackedEvent.title, order: .forward)
            case .descending:
                _allEvents = Query(filter: predicate, sort: \TrackedEvent.title, order: .reverse)
            }
        }
    }
    
    var body: some View {
        List(selection: $selection) {
            if !pinnedEvents.isEmpty {
                Section(isExpanded: $isPinnedSectionExpanded) {
                    eventList(of: pinnedEvents)
                } header: {
                    Label("Pinned", systemImage: "pin")
                }
            }
            Section(isExpanded: $isAllSectionExpanded) {
                eventList(of: allEvents)
            } header: {
                Label("All", systemImage: "list.bullet")
            }
        }
        .listStyle(.sidebar)
        .overlay {
            if allEvents.isEmpty {
                ContentUnavailableView {
                    Label("No Events", systemImage: "list.bullet.circle")
                } description: {
                    Text("Tap the plus button at the top to create a new event to track.")
                }
            }
        }
        .navigationTitle("Events")
        .onChange(of: allEvents) { eventCount = allEvents.count }
        .onAppear { eventCount = allEvents.count }
    }
    
    private func eventList(of events: [TrackedEvent]) -> some View {
        ForEach(events) { event in
            EventListItem(event: event)
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        deleteEvent(event)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button {
                        withAnimation { event.pinned.toggle() }
                    } label: {
                        if event.pinned {
                            Label("Unpin", systemImage: "pin.slash")
                        } else {
                            Label("Pin", systemImage: "pin")
                        }
                    }
                    .tint(.yellow)
                }
        }
        .onDelete(perform: deleteEvents(at:))
    }
    
    private func deleteEvents(at offsets: IndexSet) {
        withAnimation {
            offsets.map { allEvents[$0] }.forEach(deleteEvent)
        }
    }
    
    private func deleteEvent(_ event: TrackedEvent) {
        if event.persistentModelID == selection?.persistentModelID {
            selection = nil
        }
        modelContext.delete(event)
    }
    
}
