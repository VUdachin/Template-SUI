//
//  LoginView.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 08.10.2023.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    @Environment(LoginViewModel.self) var viewModel

    var body: some View {
        @Bindable var viewModel = viewModel

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
        .textFieldStyle(AuthTextFieldStyle())


        Button(action: {
            Task { viewModel.login }
        }, label: {
            Text("Sign In")
                .font(.headline)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.black)
                .background(Color.gray)
                .cornerRadius(8)
                .padding(.horizontal, 16)
        })

        _serviceDivider

        GoogleSignInButton(style: .icon) {
            //            GIDSignIn.sharedInstance.signIn(withPresenting: yourViewController) { signInResult, error in
            //                check `error`; do something with `signInResult`
            //            }
        }
        .clipShape(Circle())

//        Spacer()

        _bottomBlock
    }

    private var _serviceDivider: some View {
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

    private var _bottomBlock: some View {
        HStack {
            Text("Don't have an account?")
                .foregroundColor(Color.gray)
            Button("Sign Up") {
                // to registration
            }
        }
    }

}

#Preview {
    LoginView()
        .environment(LoginViewModel())
}
