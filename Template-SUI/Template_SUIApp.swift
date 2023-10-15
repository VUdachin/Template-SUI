//
//  Template_SUIApp.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 08.10.2023.
//

import SwiftUI
import SwiftData

@main
struct Template_SUIApp: App {
    @AppStorage(StorageKey.isSignedIn.rawValue) var isSignedIn: Bool = false

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            if isSignedIn {
                RootView()
            } else {
                LoginView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
