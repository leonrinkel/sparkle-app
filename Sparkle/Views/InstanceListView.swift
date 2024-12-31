//
//  InstanceListView.swift
//  Sparkle
//
//  Created by Leon Rinkel on 31.12.24.
//

import SwiftUI
import SwiftData

struct InstanceListView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query var instances: [LoggedInstance]
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()
    
    init(event: TrackedEvent) {
        let eventTitle = event.title
        let predicate = #Predicate<LoggedInstance> { $0.event.title == eventTitle }
        _instances = Query(filter: predicate, sort: \LoggedInstance.timestamp, order: .reverse)
    }
    
    var body: some View {
        EventForm {
            Section {
                ForEach(instances, id: \.self) { instance in
                    EventGroupBox {
                        Text(instance.timestamp, formatter: dateFormatter)
                    }
                }
            } header: {
                Text("\(instances.count) times logged")
            }
        }
    }

}

#Preview(traits: .sampleData) {
    @Previewable @Query var events: [TrackedEvent]
    NavigationStack {
        InstanceListView(event: events.first!)
    }
}
