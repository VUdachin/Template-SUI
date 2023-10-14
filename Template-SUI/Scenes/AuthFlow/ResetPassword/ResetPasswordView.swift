//
//  ResetPasswordView.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 08.10.2023.
//

import SwiftUI

struct ResetPasswordView: View {
    @Environment(ResetPasswordViewModel.self) var viewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        @Bindable var viewModel = viewModel

        VStack {
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
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
            })
        }
//        .overlay(alignment: .topLeading) {
//            HStack {
//                Button(action: {
//                    dismiss()
//                }, label: {
//                    ZStack {
//                        Circle()
//                            .fill(Color.gray)
//                            .frame(width: 35, height: 35)
//
//                        Image(systemName: "arrow.left")
//                            .frame(width: 18, height: 18)
//                    }
//                })
//            }
//            .padding(10)
//        }

    }
}

#Preview {
    ResetPasswordView()
        .environment(ResetPasswordViewModel())
}
