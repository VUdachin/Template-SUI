//
//  LoginRepositories.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 08.10.2023.
//

import Foundation
import SwiftUI
import GoogleSignIn
import AuthenticationServices

final class AuthRepository: NSObject {
    let userRepository: UserRepository

    static let shared = AuthRepository()

    private override init() {
        self.userRepository = UserRepository.shared
    }

    func login(email: String, password: String) async throws {
        do {

            let name = ""

            loginSuccess(
                name: name,
                email: email,
                authServiceType: .emailPassword
            )
        }
        catch {}
    }

    func createUser(email: String, password: String, fullname: String) async throws {
        do {
            loginSuccess(
                name: fullname,
                email: email,
                authServiceType: .emailPassword
            )
        }
        catch {}
    }

    func resetPassword(email: String) async throws {
        do {}
        catch {}
    }

    func logout() async throws {
        do {
            userRepository.currentUser = nil
        }
        catch {}
    }
}

// Google Sign In
extension AuthRepository {
    func signInWithGoogle(presenting: UIViewController, completion: @escaping (Error?) -> Void) {
        let configuration = GIDConfiguration(clientID: AuthServiceCredentials.googleClientID.rawValue)

        GIDSignIn.sharedInstance.configuration = configuration
        GIDSignIn.sharedInstance.signIn(withPresenting: presenting) { authResult, error in
            if let error = error {
                print(error)
                completion(error)
            }

            guard let authResult = authResult,
                  let profile = authResult.user.profile
            else { return }

            self.loginSuccess(
                name: profile.name,
                email: profile.email,
                photo: profile.imageURL(withDimension: 800)?.absoluteString,
                authServiceType: .google
            )
            print(authResult)
        }
    }

    func logoutGoogle() {
        GIDSignIn.sharedInstance.signOut()
        userRepository.currentUser = nil
    }
}

// Apple Sign In
extension AuthRepository: ASAuthorizationControllerDelegate {
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
            guard 
                let name = appleIdCredential.fullName?.givenName,
                let surname = appleIdCredential.fullName?.familyName,
                let email = appleIdCredential.email
            else { return }

            loginSuccess(
                name: "\(name) \(surname)",
                email: email,
                authServiceType: .apple
            )
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
    }
}

extension AuthRepository {
    private func loginSuccess(
        name: String,
        email: String,
        photo: String? = nil,
        authServiceType: AuthServiceType
    ) {
        userRepository.currentUser = User(
            name: name,
            email: email,
            photo: photo,
            authServiceType: authServiceType
        )
        UserDefaults.standard.set(true, forKey: StorageKey.isSignedIn.rawValue)
    }
}