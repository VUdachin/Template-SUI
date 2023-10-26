//
//  Template_SUIApp.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 08.10.2023.
//

import SwiftUI
import SwiftData
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

final class AppDelegate: NSObject, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()

        return true
    }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct Template_SUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
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
