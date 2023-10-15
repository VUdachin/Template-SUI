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

    func changeName(to: String) {}

    func changeEmail(to: String) {}

    func savePhoto(photo: UIImage) {}

    func removePhoto() {}
}
