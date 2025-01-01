//
//  ContentView.swift
//  Sparkle
//
//  Created by Leon Rinkel on 30.12.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var selection: TrackedEvent?
    @State private var eventCount = 0
    @State private var searchText: String = ""
    @State private var showAddEvent: Bool = false

    var body: some View {
        NavigationSplitView {
            EventsListView(selection: $selection, eventCount: $eventCount, searchText: searchText)
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                        .disabled(eventCount == 0)
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Spacer()
                    Button {
                        showAddEvent = true
                    } label: {
                        Label("Log Event", systemImage: "plus")
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
