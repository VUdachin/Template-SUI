//
//  RegistrationView.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 08.10.2023.
//

import SwiftUI

struct RegistrationView: View {
    @State var viewModel = RegistrationViewModel()

    var body: some View {
        VStack {
            Group {
                Text("Register")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 16)

                TextField("Enter your email", text: $viewModel.email) { _ in
                    if !viewModel.isEmailValid {
                        viewModel.checkEmailValidity()
                    }
                }
                .textContentType(.emailAddress)

                TextField("Enter your name", text: $viewModel.fullName)
                    .textContentType(.name)

                VStack {
                    if viewModel.isPasswordSecured {
                        SecureField("Enter your password", text: $viewModel.password)
                        // тут тоже проверка
                    } else {
                        TextField("Enter your password", text: $viewModel.password) { _ in
                            if !viewModel.isPasswodValid {
                                viewModel.checkPasswordValidity()
                            }
                        }
                    }
                }
                .textContentType(.password)
                .overlay(
                    Button(action: {
                        viewModel.toggleSecure()
                    }, label: {
                        Image(systemName: viewModel.isPasswordSecured ? "eye.fill" : "eye.slash.fill")
                            .foregroundStyle(.black)
                    })
                    .padding(.horizontal, 28),
                    alignment: .trailing
                )
            }
            .textFieldStyle(AuthTextFieldStyle())

            Button(action: {
                Task { viewModel.createUser }
            }, label: {
                Text("Sign Up")
                    .font(.headline)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.black)
                    .background(Color.gray)
                    .cornerRadius(10)
                    .padding()
            })

            _serviceDividerView

            AuthServicesView { actionType in
                switch actionType {
                case .apple:
                    viewModel.signInWithApple()
                case .google:
                    Task { await viewModel.signInWithGoogle(presenting: getRootViewController()) }
                case .emailPassword: break
                }
            }
        }
    }

    private var _serviceDividerView: some View {
        Divider()
            .frame(height: 2)
            .background(Color.gray.opacity(0.5))
            .overlay(
                Text("or login with")
                    .padding(.horizontal, 12)
                    .background(.white)
            )
            .padding(.vertical, 32)
            .padding(.horizontal, 16)
    }
}

#Preview {
    RegistrationView()
}
