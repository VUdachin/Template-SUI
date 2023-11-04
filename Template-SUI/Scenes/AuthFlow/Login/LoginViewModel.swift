//
//  LoginViewModel.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 08.10.2023.
//

import Foundation
import SwiftUI

enum LoginNavigationDestination: String, Hashable, Identifiable {
    var id: String { self.rawValue }

    case signUp
    case forgotPassword
}

@Observable
final class LoginViewModel {
    private let authRepository: AuthRepository
    private let validationHelper: ValidationHelper
    private let isModal: Bool

    init(isModal: Bool = false) {
        self.authRepository = AuthRepository.shared
        self.validationHelper = ValidationHelper()
        self.isModal = isModal
    }

    var email: String = ""
    var password: String = ""
    var isPasswordSecured: Bool = true

    var isEmailValid: Bool = true
    var isPasswodValid: Bool = true

    var navigationDestination: LoginNavigationDestination?
    var navigationDestinationModal: LoginNavigationDestination?

    func login() async throws {
        checkEmailValidity()
        checkEmailValidity()

        guard isEmailValid && isPasswodValid else {
            throw AuthError.validationError
        }

        do {
            try await authRepository.login(email: email, password: password)
        } catch {
            print(error.localizedDescription)
        }
    }

    func signInWithGoogle(presenting: UIViewController) async {
        do {
            try await authRepository.signInWithGoogle(presenting: presenting)
        } catch {
            print(error.localizedDescription)
        }
    }

    func signUpTap() {
        isModal ? (navigationDestinationModal = .signUp) : (navigationDestination = .signUp)
    }

    func forgotPasswordTap() {
        isModal ? (navigationDestinationModal = .forgotPassword) : (navigationDestination = .forgotPassword)
    }

    func signInWithApple() {
        authRepository.performAppleSignIn()
    }

    func toggleSecure() {
        isPasswordSecured.toggle()
    }

    func checkEmailValidity() {
        isEmailValid = validationHelper.isEmailValid(email)
    }

    func checkPasswordValidity() {
        isPasswodValid = validationHelper.isPasswordValid(password)
    }
}
