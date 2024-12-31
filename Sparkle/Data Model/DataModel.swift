//
//  DataModel.swift
//  Sparkle
//
//  Created by Leon Rinkel on 30.12.24.
//

import Foundation
import SwiftData

actor DataModel {
    
    static let shared = DataModel()
    private init() {}
    
    nonisolated lazy var modelContainer: ModelContainer = {
        let modelContainer: ModelContainer
        do {
            modelContainer = try ModelContainer(for: TrackedEvent.self)
        } catch {
            fatalError("Failed to create the model container: \(error)")
        }
        return modelContainer
    }()

}
