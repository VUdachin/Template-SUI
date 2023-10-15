//
//  LoginViewModel.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 08.10.2023.
//

import Foundation
import SwiftUI

@Observable
final class LoginViewModel {
    private let authRepository: AuthRepository
    private let validationHelper: ValidationHelper

    init() {
        self.authRepository = AuthRepository.shared
        self.validationHelper = ValidationHelper()
    }

    var email: String = ""
    var password: String = ""
    var isPasswordSecured: Bool = true

    var isEmailValid: Bool = true
    var isPasswodValid: Bool = true

    func login() async throws {
        checkEmailValidity()
        checkEmailValidity()

        guard isEmailValid && isPasswodValid else {
            throw AuthError.validationError
        }

        try await authRepository.login(email: email, password: password)
    }

    func signInWithGoogle(presenting: UIViewController) async {
        do {
            try await authRepository.signInWithGoogle(presenting: presenting)
        } catch {
            print(error.localizedDescription)
            // Create error
        }
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
