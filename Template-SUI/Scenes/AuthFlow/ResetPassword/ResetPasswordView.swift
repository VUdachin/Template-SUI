//
//  ResetPasswordView.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 08.10.2023.
//

import SwiftUI

struct ResetPasswordView: View {
    @State var viewModel = ResetPasswordViewModel()

    var body: some View {
        Spacer()

        Text("Forgot Password?")
            .font(.title)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 4)
            .padding(.horizontal, 16)

        Text("Don't worry, it occurs! Please enter the email address linked to your account.")
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        
        TextField("Enter your email", text: $viewModel.email) { _ in
            if !viewModel.isEmailValid {
                viewModel.checkEmailValidity()
            }
        }
        .textContentType(.emailAddress)
        .textFieldStyle(AuthTextFieldStyle())

        Button(action: {
            Task { viewModel.resetPassword }
        }, label: {
            Text("Send request")
                .font(.headline)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.black)
                .background(Color.gray)
                .cornerRadius(10)
                .padding()
        })
    }
}

#Preview {
    ResetPasswordView()
}
