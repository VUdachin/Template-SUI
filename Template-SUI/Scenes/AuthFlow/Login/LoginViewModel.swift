//
//  LoginViewModel.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 08.10.2023.
//

import Foundation

@Observable
final class LoginViewModel {
    private let authService: AuthService
    private let validationHelper: ValidationHelper

    init() {
        self.authService = AuthService()
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

        try await authService.login(email: email, password: password)
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
