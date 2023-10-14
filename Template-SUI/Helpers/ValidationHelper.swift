//
//  ValidationHelper.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 08.10.2023.
//

import Foundation

public struct ValidationHelper {
    public func isEmailValid(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    public func isPasswordValid(_ password: String) -> Bool {
        let passwordRegex = "(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
}
