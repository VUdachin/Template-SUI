//
//  CryptoUtils.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 21.10.2023.
//

import Foundation
import CryptoKit

enum CryptoUtils {
  enum NonceGenerationError: Error {
    case generationFailure(status: OSStatus)
  }

  static func randomNonceString(length: Int = 32) throws -> String {
    precondition(length > 0)
    var randomBytes = [UInt8](repeating: 0, count: length)
    let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
    if errorCode != errSecSuccess {
      throw NonceGenerationError.generationFailure(status: errorCode)
    }

    let charset: [Character] =
      Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

    let nonce = randomBytes.map { byte in
      // Pick a random character from the set, wrapping around if needed.
      charset[Int(byte) % charset.count]
    }

    return String(nonce)
  }

  static func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
      String(format: "%02x", $0)
    }.joined()

    return hashString
  }
}
