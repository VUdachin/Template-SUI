//
//  RootView.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 08.10.2023.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView() {
            Group {
                ContentView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }

                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
            }
            .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

#if DEBUG
#Preview {
    RootView()
}
#endif
