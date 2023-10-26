//
//  UserRepository.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 15.10.2023.
//

import Foundation
import UIKit
import Firebase

@Observable
final class UserRepository {
    private let firebaseRepository: FirebaseRepository
    var currentUser: Firebase.User?

    static let shared = UserRepository()

    private init() {
        self.firebaseRepository = FirebaseRepository.shared
        self.currentUser = firebaseRepository.auth.currentUser
    }

    func changeUserData(
        userName: String,
        email: String,
        photo: UIImage?
    ) async throws {
        do {
            try await updateUserEmail(email)

            let changeRequest = firebaseRepository.auth.currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = userName
            if let path = try await getSavedPhotoPath(photo: photo) {
                changeRequest?.photoURL = URL(string: path)
            }

            try await changeRequest?.commitChanges()
        } catch {
            throw error
        }
    }

    func removePhoto() async throws {
        do {
            let changeRequest = firebaseRepository.auth.currentUser?.createProfileChangeRequest()
            changeRequest?.photoURL = nil
            try await changeRequest?.commitChanges()
        } catch {
            throw error
        }
    }

    func deleteUser() async throws {
        do {
            let user = firebaseRepository.auth.currentUser
            try await user?.delete()
        } catch {
            throw error
        }

    }
}

extension UserRepository {
    private func getSavedPhotoPath(photo: UIImage?) async throws -> String? {
        do {
            guard let data = photo?.pngData(), let currentUser else { return nil }

            let photosRef = firebaseRepository.storage.reference().child("photos/\(currentUser.uid)")
            try await photosRef.putDataAsync(data)
            return try await photosRef.downloadURL().absoluteString
        } catch {
            throw error
        }
    }

    private func updateUserEmail(_ newEmail: String) async throws {
        do {
            try await firebaseRepository.auth.currentUser?.updateEmail(to: newEmail)
        } catch {
            throw error
        }
    }
}
