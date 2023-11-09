//
//  AdvancedLearningApp.swift
//  AdvancedLearning
//
//  Created by Назар Горевой on 09.11.2023.
//

import SwiftUI

@main
struct AdvancedLearningApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
