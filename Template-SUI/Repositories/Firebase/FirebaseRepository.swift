//
//  FirebaseRepository.swift
//  Template-SUI
//
//  Created by Vladimir Udachin on 21.10.2023.
//

import Firebase
import FirebaseCore
import FirebaseStorage

final class FirebaseRepository: NSObject {
    let auth: Auth
    let storage: Storage

    static let shared = FirebaseRepository()

    override private init() {
        self.auth = Auth.auth()
        self.storage = Storage.storage()

        super.init()
    }
}
