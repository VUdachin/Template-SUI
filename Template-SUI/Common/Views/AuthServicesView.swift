//
//  AuthServicesView.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 15.10.2023.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct AuthServicesView: View {
    var action: (AuthServiceType) -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            GoogleSignInButton(style: .icon) {
                action(.google)
            }
            .clipShape(Circle())

            Button {
                action(.apple)
            } label: {
                Text("Apple Sign In")
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
}

#Preview {
    AuthServicesView(action: { _ in })
}
