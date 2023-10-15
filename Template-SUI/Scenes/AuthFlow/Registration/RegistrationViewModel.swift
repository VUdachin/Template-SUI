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
    private let authService: AuthService
    private let validationHelper: ValidationHelper

    init(email: String = "") {
        self.authService = AuthService()
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

        try await authService.createUser(
            email: email,
            password: password,
            fullname: fullName
        )
    }

    func signInWithGoogle(presenting: UIViewController) {
        authService.signInWithGoogle(presenting: presenting) { error in
            print(error)
        }
    }

    func signInWithApple() {
        authService.performAppleSignIn()
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
