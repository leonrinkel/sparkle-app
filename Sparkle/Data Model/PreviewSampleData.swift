//
//  PreviewSampleData.swift
//  Sparkle
//
//  Created by Leon Rinkel on 30.12.24.
//

import SwiftData
import SwiftUI

struct SampleData: PreviewModifier {
    
    static func makeSharedContext() throws -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: TrackedEvent.self, configurations: config)
        SampleData.createSampleData(into: container.mainContext)
        return container
    }
    
    static func createSampleData(into modelContext: ModelContext) {
        Task { @MainActor in
            let sampleEvents: [TrackedEvent] = TrackedEvent.previewEvents
            let sampleInstances: [LoggedInstance] = LoggedInstance.previewInstances
            
            let sampleData: [any PersistentModel] = sampleEvents + sampleInstances
            sampleData.forEach {
                modelContext.insert($0)
            }
            try? modelContext.save()
        }
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
    
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var sampleData: Self = .modifier(SampleData())
}
