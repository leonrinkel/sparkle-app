//
//  SparkleApp.swift
//  Sparkle
//
//  Created by Leon Rinkel on 30.12.24.
//

import SwiftUI
import SwiftData

@main
struct SparkleApp: App {

    let modelContainer = DataModel.shared.modelContainer

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }

}
