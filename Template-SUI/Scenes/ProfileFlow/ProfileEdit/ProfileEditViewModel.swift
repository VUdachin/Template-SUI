//
//  ProfileViewModel.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 18.10.2023.
//

import Foundation
import UIKit

@Observable
final class ProfileEditViewModel {
    let userRepository: UserRepository

    var userName: String
    var email: String
    var photo: ImageSourceType

    var selectedPhoto: UIImage?
    var isImagePickerPresented = false

    init() {
        self.userRepository = UserRepository.shared
        self.userName = userRepository.currentUser?.name ?? ""
        self.email = userRepository.currentUser?.email ?? ""
        self.photo = userRepository.currentUser?.photo ?? .none
    }

    func removePhotoTapped() async throws {
        selectedPhoto = nil
        try await userRepository.removePhoto()
    }

    func saveEditsTapped() {
        userRepository.changeUserData(
            userName: userName,
            email: email,
            photo: selectedPhoto
        )
    }

    func changePhotoTapped() {
        isImagePickerPresented = true
    }
}
