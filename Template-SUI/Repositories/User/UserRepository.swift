//
//  UserRepository.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 15.10.2023.
//

import Foundation
import UIKit

final class UserRepository {
    var currentUser: User?

    static let shared = UserRepository()

    private init(currentUser: User? = nil) {
        self.currentUser = currentUser // Set data from storage
    }

    func changeUserData(
        userName: String,
        email: String,
        photo: UIImage?
    ) {
        updateUserData(userName, email, photo)
    }

    func removePhoto() {}
}

extension UserRepository {
    private func updateUserData(
        _ userName: String,
        _ email: String,
        _ photo: UIImage?
    ) {
        currentUser?.name = userName
        currentUser?.email = email
//        currentUser?.photo = photo
    }
}
