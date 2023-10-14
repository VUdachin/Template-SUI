//
//  ResetPasswordViewModel.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 08.10.2023.
//

import Foundation

@Observable
final class ResetPasswordViewModel {
    private let authService: AuthService
    private let validationHelper: ValidationHelper

    init() {
        self.authService = AuthService()
        self.validationHelper = ValidationHelper()
    }

    var email: String = ""
    var isEmailValid: Bool = true

    func resetPassword() async throws {
        try await authService.resetPassword(email: email)
    }

    func checkEmailValidity() {
        isEmailValid = validationHelper.isEmailValid(email)
    }
}
