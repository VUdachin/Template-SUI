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
    var photoURL: URL?

    var selectedPhoto: UIImage?
    var isImagePickerPresented = false
    var shouldDismiss = false

    init() {
        self.userRepository = UserRepository.shared
        self.userName = userRepository.currentUser?.displayName ?? ""
        self.email = userRepository.currentUser?.email ?? ""
        self.photoURL = userRepository.currentUser?.photoURL
    }

    deinit {
        print("deinit")
    }

    func removePhotoTapped() async throws {
        do {
            try await userRepository.removePhoto()
            selectedPhoto = nil
            shouldDismiss.toggle()
        } catch {
            print(error)
        }
    }

    func saveEditsTapped() async throws {
        do {
            try await userRepository.changeUserData(
                userName: userName,
                email: email,
                photo: selectedPhoto
            )
            shouldDismiss.toggle()
        } catch {
            print(error)
        }

    }

    func changePhotoTapped() {
        isImagePickerPresented = true
    }
}
