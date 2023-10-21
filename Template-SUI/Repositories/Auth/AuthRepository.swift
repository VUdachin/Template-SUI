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
    private let userRepository: UserRepository

    static let shared = AuthRepository()

    private override init() {
        self.userRepository = UserRepository.shared
    }
}

// Default methods
extension AuthRepository {
    func login(email: String, password: String) async throws {
        do {
            // MARK: - Set your async method here
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
            // MARK: - Set your async method here
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
            // MARK: - Set your async method here
            UserDefaults.standard.set(false, forKey: StorageKey.isSignedIn.rawValue)
            userRepository.currentUser = nil
            logoutGoogle()
        }
        catch {}
    }
}

// Google Sign In
extension AuthRepository {
    func signInWithGoogle(presenting: UIViewController) async throws {
        let configuration = GIDConfiguration(clientID: AuthServiceCredentials.googleClientID.rawValue)

        GIDSignIn.sharedInstance.configuration = configuration
        do {
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: presenting)

            guard let profile = result.user.profile else { return }

            self.loginSuccess(
                name: profile.name,
                email: profile.email,
//                photo: .link(profile.imageURL(withDimension: 800)?.absoluteString), // change
                authServiceType: .google
            )
        } catch {
            throw error
        }
    }

    func logoutGoogle() {
        GIDSignIn.sharedInstance.signOut()
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
        photo: ImageSourceType = .none,
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
