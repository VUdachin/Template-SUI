//
//  View+RootViewController.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 15.10.2023.
//

import SwiftUI

extension View {
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .init() }

        guard let root = screen.windows.first?.rootViewController else { return .init() }

        return root
    }
}
