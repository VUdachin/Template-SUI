//
//  ProfileEditView.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 18.10.2023.
//

import SwiftUI

struct ProfileEditView: View {
    @State var viewModel = ProfileEditViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 16) {
                    _profilePhoto

                    Button {
                        Task { try await viewModel.removePhotoTapped() }
                    } label: {
                        Text("Remove photo")
                    }

                    Rectangle()
                        .frame(height: 20)
                        .clipShape(
                            .rect(
                                topLeadingRadius: 20,
                                topTrailingRadius: 20
                            )
                        )
                        .foregroundStyle(Color.white)
                }
                .background(Color.gray.opacity(0.7))

                VStack(alignment: .leading) {
                    Text("Username")
                        .modifier(TitleTextStyle())

                    TextField("Enter your name", text: $viewModel.userName)
                        .autocapitalization(.none)
                        .keyboardType(.default)
                        .textContentType(.name)
                        .disableAutocorrection(true)
                        .textFieldStyle(AuthTextFieldStyle())

                    Text("Email")
                        .modifier(TitleTextStyle())

                    TextField("Enter your email", text: $viewModel.email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .disableAutocorrection(true)
                        .textFieldStyle(AuthTextFieldStyle())
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)

                Spacer()
            }
            .navigationTitle("Edit profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        Task { try await viewModel.saveEditsTapped() }
                    }
                }
            }
            .onChange(of: viewModel.shouldDismiss) {
                dismiss()
            }
        }
    }

    private var _profilePhoto: some View {
        VStack {
            if let selectedPhoto = viewModel.selectedPhoto {
                CircleAvatarView(image: .image(selectedPhoto))
                    .overlay(
                        Image(systemName: "pencil.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .offset(x: -2, y: -2)
                            .foregroundStyle(Color.white)
                        ,alignment: .bottomTrailing
                    )
            } else {
                CircleAvatarView(image: .link(viewModel.photoURL))
                    .overlay(
                        Image(systemName: "pencil.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .offset(x: -2, y: -2)
                            .foregroundStyle(Color.white)
                        ,alignment: .bottomTrailing
                    )
            }
        }
        .onTapGesture {
            viewModel.changePhotoTapped()
        }
        .sheet(isPresented: $viewModel.isImagePickerPresented) {
            ImagePickerView(selectedImage: $viewModel.selectedPhoto)
        }
    }
}

#if DEBUG
#Preview {
    ProfileEditView(viewModel: ProfileEditViewModel())
}
#endif
