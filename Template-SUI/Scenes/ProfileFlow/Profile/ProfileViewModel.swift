//
//  ProfileViewModel.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 17.10.2023.
//

import Foundation

@Observable
final class ProfileViewModel {
    let authRepository: AuthRepository
    let userRepository: UserRepository

    var userName: String? { userRepository.currentUser?.name }
    var email: String? { userRepository.currentUser?.email }
    var photo: String? { userRepository.currentUser?.photo }

    init() {
        self.authRepository = AuthRepository.shared
        self.userRepository = UserRepository.shared
    }

    func logOutTapped() async throws {
        try await authRepository.logout()
    }

    func profileEditTapeped() {
        
    }

    func privacyPolicyTapped() {
        
    }
}
