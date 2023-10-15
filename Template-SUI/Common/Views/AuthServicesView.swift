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
        HStack(alignment: .center, spacing: 16) {
            GoogleSignInButton(style: .icon) {
                action(.google)
            }
            .clipShape(Circle())

            Button {
                action(.apple)
            } label: {
                Image(systemName: "apple.logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.black)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 20)
        .padding(.horizontal)
    }
}

#Preview {
    AuthServicesView(action: { _ in })
}
