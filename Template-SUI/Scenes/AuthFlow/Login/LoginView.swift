//
//  LoginView.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 08.10.2023.
//

import SwiftUI

struct LoginView: View {
    @State var viewModel = LoginViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                Text("Login")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 16)

                Group {
                    TextField("Enter your email", text: $viewModel.email) { _ in
                        if !viewModel.isEmailValid {
                            viewModel.checkEmailValidity()
                        }
                    }
                    .textContentType(.emailAddress)

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
                .padding(.horizontal, 16)
                .textFieldStyle(AuthTextFieldStyle())

                Button(action: {
                    viewModel.forgotPasswordTap()
                }, label: {
                    Text("Forgot Password?")
                        .font(.subheadline.bold())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.vertical, 8)
                        .padding(.trailing, 16)
                })

                Button(action: {
                    Task {
                        try await viewModel.login()
                        dismiss()
                    }
                }, label: {
                    Text("Sign In")
                        .font(.headline)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.black)
                        .background(Color.gray)
                        .cornerRadius(10)
                        .padding(.horizontal)
                })

                _serviceDividerView

                AuthServicesView { actionType in
                    switch actionType {
                    case .apple:
                        viewModel.signInWithApple()
                    case .google:
                        Task {
                            await viewModel.signInWithGoogle(presenting: getRootViewController())
                            dismiss()
                        }
                    case .emailPassword: break
                    }
                }

                _authSelectionView
            }
            .sheet(item: $viewModel.navigationDestinationModal) { route in
                switch route {
                case .signUp:
                    RegistrationView(
                        viewModel: RegistrationViewModel(email: viewModel.email)
                    )
                case .forgotPassword:
                    ResetPasswordView(
                        viewModel: ResetPasswordViewModel(
                            email: viewModel.email)
                    )
                }
            }
            .navigationDestination(item: $viewModel.navigationDestination) { route in
                switch route {
                case .signUp:
                    RegistrationView(
                        viewModel: RegistrationViewModel(email: viewModel.email)
                    )
                case .forgotPassword:
                    ResetPasswordView(
                        viewModel: ResetPasswordViewModel(email: viewModel.email)
                    )
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

    private var _authSelectionView: some View {
        HStack {
            Text("Don't have an account?")
                .foregroundColor(Color.gray)
            Button(action: {
                viewModel.signUpTap()
            }, label: {
                Text("Sign In")
            })
        }
        .padding()
    }
}

#if DEBUG
#Preview {
    LoginView()
}
#endif
