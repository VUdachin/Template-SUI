//
//  RegistrationViewModel.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 08.10.2023.
//

import Foundation
import SwiftUI

@Observable
final class RegistrationViewModel {
    private let authRepository: AuthRepository
    private let validationHelper: ValidationHelper

    init(email: String = "") {
        self.authRepository = AuthRepository.shared
        self.validationHelper = ValidationHelper()
        self.email = email
    }

    var email: String = ""
    var password: String = ""
    var fullName: String = ""
    var isPasswordSecured: Bool = true


    var isEmailValid: Bool = true
    var isPasswodValid: Bool = true
    var fullNameValid: Bool = true

    func createUser() async throws {
        checkEmailValidity()
        checkEmailValidity()

        guard isEmailValid && isPasswodValid else {
            throw AuthError.validationError
        }

        try await authRepository.createUser(
            email: email,
            password: password,
            fullname: fullName
        )
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
