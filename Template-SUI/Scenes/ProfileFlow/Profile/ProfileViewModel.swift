//
//  ProfileViewModel.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 17.10.2023.
//

import Foundation

enum ProfileNavigationDestination: String, Hashable, Identifiable {
    var id: String { self.rawValue }

    case signIn
    case signUp
    case profileEdit
    case privacyPolicy
}

@Observable
final class ProfileViewModel {
    let authRepository: AuthRepository
    let userRepository: UserRepository

    var userName: String? { userRepository.currentUser?.displayName }
    var email: String? { userRepository.currentUser?.email }
    var photo: URL? { userRepository.currentUser?.photoURL }

    var navigationDestination: ProfileNavigationDestination?
    var navigationDestinationModal: ProfileNavigationDestination?

    init() {
        self.authRepository = AuthRepository.shared
        self.userRepository = UserRepository.shared
    }

    func logOutTap() async throws {
        try await authRepository.logout()
    }

    func signInTap() {
        navigationDestinationModal = .signIn
    }

    func signUpTap() {
        navigationDestinationModal = .signUp
    }

    func profileEditTap() {
        navigationDestinationModal = .profileEdit
    }

    func privacyPolicyTap() {
        navigationDestination = .privacyPolicy
    }
}
