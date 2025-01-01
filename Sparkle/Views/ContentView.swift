//
//  ContentView.swift
//  Sparkle
//
//  Created by Leon Rinkel on 30.12.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var order = EventsSortOrder()
    @State private var selection: TrackedEvent?
    @State private var eventCount = 0
    @State private var searchText: String = ""
    @State private var showAddEvent: Bool = false

    var body: some View {
        NavigationSplitView {
            EventsListView(order: $order, selection: $selection, eventCount: $eventCount, searchText: searchText)
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .topBarLeading) {
                    if eventCount > 0 {
                        EditButton()
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        showAddEvent = true
                    } label: {
                        Label("Log Event", systemImage: "plus")
                    }
                    Menu {
                        Menu {
                            Picker(selection: $order.listBy) {
                                ForEach(EventsListBy.allCases) { option in
                                    Text(String(describing: option))
                                }
                            } label: {
                                Text("Events Sort Order")
                            }
                            if order.listBy == .dateAdded {
                                Divider()
                                Picker(selection: $order.dateAddedOrder) {
                                    ForEach(DateAddedOrder.allCases) { option in
                                        Text(String(describing: option))
                                    }
                                } label: {}
                            }
                            if order.listBy == .title {
                                Divider()
                                Picker(selection: $order.titleOrder) {
                                    ForEach(TitleOrder.allCases) { option in
                                        Text(String(describing: option))
                                    }
                                } label: {}
                            }
                        } label: {
                            Label("Sort By", systemImage: "arrow.up.arrow.down")
                        }
                    } label: {
                        Label("Menu", systemImage: "ellipsis.circle")
                    }
                }
#endif
            }
        } detail: {
            if let selection = selection {
                NavigationStack {
                    EventDetailView(event: selection)
                }
            }
        }
        .searchable(text: $searchText, placement: .sidebar)
        .sheet(isPresented: $showAddEvent) {
            NavigationStack {
                AddEventView()
            }
        }
    }

}

#Preview(traits: .sampleData) {
    ContentView()
}
