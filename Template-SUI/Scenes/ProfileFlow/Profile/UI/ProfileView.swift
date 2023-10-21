//
//  SettingsView.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 08.10.2023.
//

import SwiftUI

struct ProfileView: View {
    @State var viewModel = ProfileViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack {
                    if let userName = viewModel.userName, let email = viewModel.email {
                        ProfileSummaryView(
                            userName: userName,
                            email: email,
                            image: viewModel.photo
                        )
                    } else {
                        Text("Log in or register to take full advantage of the app.")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16)

                        NavigationLink(destination: {
                            LoginView()
                        }, label: {
                            Text("Sign In")
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.white)
                                .background(Color.gray)
                                .cornerRadius(8)
                        })
                        .padding(.horizontal, 16)

                        NavigationLink(destination: {
                            RegistrationView()
                        }, label: {
                            Text("Sign Up")
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.white)
                                .background(Color.gray)
                                .cornerRadius(8)
                        })
                        .padding(.horizontal, 16)
                    }
                }
                .background(Color.gray.opacity(0.7))


                VStack {
                    Rectangle()
                        .frame(height: 20)
                        .clipShape(
                            .rect(
                                topLeadingRadius: 20,
                                topTrailingRadius: 20
                            )
                        )
                        .foregroundStyle(Color.white)
                        .padding(.top, 16)
                }
                .background(Color.gray.opacity(0.7))

                List {
                    if viewModel.userRepository.currentUser != nil {
                        NavigationLink(destination: {
                            ProfileEditView()
                        }, label: {
                            Text("Edit profile")
                        })
                    }

                    Button(action: {
                        viewModel.privacyPolicyTapped()
                    }, label: {
                        Text("Privacy policy")
                    })

                    if viewModel.userRepository.currentUser != nil {
                        Button(action: {
                            Task { try await viewModel.logOutTapped() }
                        }, label: {
                            Text("Logout")
                                .foregroundStyle(Color.red)
                        })
                    }
                }
                .listStyle(.plain)
                .scrollDisabled(true)
            }
            .navigationTitle("Profile")
        }
    }
}

#if DEBUG
#Preview {
    ProfileView(viewModel: ProfileViewModel())
}
#endif
