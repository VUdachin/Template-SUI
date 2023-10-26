//
//  ResetPasswordViewModel.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 08.10.2023.
//

import Foundation

@Observable
final class ResetPasswordViewModel {
    private let authRepository: AuthRepository
    private let validationHelper: ValidationHelper

    init(email: String = "") {
        self.authRepository = AuthRepository.shared
        self.validationHelper = ValidationHelper()
        self.email = email
    }

    var email: String
    var isEmailValid: Bool = true

    func resetPassword() async throws {
        do {
            try await authRepository.resetPassword(email: email)
        } catch {
            print(error.localizedDescription)
        }
    }

    func checkEmailValidity() {
        isEmailValid = validationHelper.isEmailValid(email)
    }
}
