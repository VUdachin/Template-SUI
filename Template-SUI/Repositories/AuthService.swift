//
//  LoginRepositories.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 08.10.2023.
//

enum AuthError: Error {
    case validationError
}

import Foundation
import SwiftUI
import GoogleSignIn
import AuthenticationServices

final class AuthService: NSObject {

    func login(email: String, password: String) async throws {
        do {
//            loginSuccess()
        }
        catch {}
    }

    func createUser(email: String, password: String, fullname: String) async throws {
        do {
//            loginSuccess()
        }
        catch {}
    }

    func resetPassword(email: String) async throws {
        do {}
        catch {}
    }

    func logout() async throws {
        do {}
        catch {}
    }
}

// Google Sign In
extension AuthService {
    func signInWithGoogle(presenting: UIViewController, completion: @escaping (Error?) -> Void) {
        GIDSignIn.sharedInstance.signIn(withPresenting: presenting) { authResult, error in
            if let error = error {
                print(error)
                completion(error)
            }

            guard let authResult = authResult else { return }

            self.loginSuccess()
            print(authResult)
        }
    }
}

// Apple Sign In
extension AuthService: ASAuthorizationControllerDelegate {
    func performAppleSignIn() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }

    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let token = appleIdCredential.identityToken?.base64EncodedString() else { return }

            // MARK: TODO
            /// 1. Set token here
            /// 2. Perform tasks to do after login
            loginSuccess()
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
    }
}

extension AuthService {
    private func loginSuccess() {
        UserDefaults.standard.set(true, forKey: StorageKey.isSignedIn.rawValue)
    }
}
