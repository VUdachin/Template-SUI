//
//  LoginRepositories.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 08.10.2023.
//

import SwiftUI
import GoogleSignIn
import AuthenticationServices
import FirebaseCore
import FirebaseAuth

final class AuthRepository: NSObject {
    private let userRepository: UserRepository
    private let firebaseRepository: FirebaseRepository

    static let shared = AuthRepository()

    // For Sign in with Apple
    var currentNonce: String?

    private override init() {
        self.userRepository = UserRepository.shared
        self.firebaseRepository = FirebaseRepository.shared
    }
}

// Default methods
extension AuthRepository {
    public func login(email: String, password: String) async throws {
        do {
            try await firebaseRepository.auth.signIn(withEmail: email, password: password)
            authSuccess()
        } catch {
            throw error
        }
    }

    public func createUser(email: String, password: String, fullname: String) async throws {
        do {
            try await firebaseRepository.auth.createUser(withEmail: email, password: password)
            authSuccess()
        } catch {
            throw error
        }
    }

    public func resetPassword(email: String) async throws {
        do {
            try await firebaseRepository.auth.sendPasswordReset(withEmail: email)
        } catch {
            throw error
        }
    }

    public func logout() async throws {
        do {
            try firebaseRepository.auth.signOut()
            UserDefaults.standard.set(false, forKey: StorageKey.isSignedIn.rawValue)
            userRepository.currentUser = nil
            logoutGoogle()
        } catch {
            throw error
        }
    }
}

// Google Sign In
extension AuthRepository {
    public func signInWithGoogle(presenting: UIViewController) async throws {
        do {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)

            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: presenting)
            guard let idToken = result.user.idToken?.tokenString else { return }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: result.user.accessToken.tokenString)
            try await firebaseAuth(credential: credential)
        } catch {
            throw error
        }
    }

    public func logoutGoogle() {
        GIDSignIn.sharedInstance.signOut()
    }
}

// Apple Sign In
extension AuthRepository: ASAuthorizationControllerDelegate {
    public func performAppleSignIn() {
        do {
            let nonce = try CryptoUtils.randomNonceString()
            currentNonce = nonce

            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            request.nonce = CryptoUtils.sha256(nonce)

            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            //          authorizationController.presentationContextProvider = self // ??
            authorizationController.performRequests()
        } catch {
            // In the unlikely case that nonce generation fails, show error view.
            print(error)
        }

        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }

    private func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) async throws {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential
        else {
            print("Unable to retrieve AppleIDCredential")
            return
        }

        guard let nonce = currentNonce else {
            fatalError("Invalid state: A login callback was received, but no login request was sent.")
        }

        guard let appleIDToken = appleIDCredential.identityToken else {
            print("Unable to fetch identity token")
            return
        }
        guard let appleAuthCode = appleIDCredential.authorizationCode else {
            print("Unable to fetch authorization code")
            return
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
            return
        }

        guard let _ = String(data: appleAuthCode, encoding: .utf8) else {
            print("Unable to serialize auth code string from data: \(appleAuthCode.debugDescription)")
            return
        }
        
        let firebaseCredential = OAuthProvider.appleCredential(
            withIDToken: idTokenString,
            rawNonce: nonce,
            fullName: appleIDCredential.fullName
        )

        try await firebaseAuth(credential: firebaseCredential)
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
    }
}

extension AuthRepository {
    private func authSuccess() {
        UserDefaults.standard.set(true, forKey: StorageKey.isSignedIn.rawValue)
    }

    private func firebaseAuth(credential: AuthCredential) async throws {
        do {
            try await firebaseRepository.auth.signIn(with: credential)
            authSuccess()
        } catch {
            throw error
        }
    }
}
