//
//  FirebaseInterface.swift
//  MyChatApp
//
//  Created by Prof_K on 29/07/2023.
//

import Foundation
import FirebaseAuth

protocol FirebaseInterface {
    var firebaseAuth: Auth { get }
    
}

protocol RegisterUserInterface: FirebaseInterface {
    func registerUser(email: String,
                      password: String,
                      completion: @escaping (AuthDataResult) -> (),
                      errorHandler: @escaping (String) -> ()?)
    func signIn(with email: String,
                and password: String,
                completion: @escaping (AuthDataResult) -> (),
                errorHandler: @escaping (String) -> ()?)
}

protocol LogoutUserInterface: FirebaseInterface {
    func signOut(completion: @escaping () -> ())
}

extension LogoutUserInterface {
    func signOut(completion: @escaping () -> ()) {
        do {
            try firebaseAuth.signOut()
            completion()
        } catch {
            print("failed to log out")
        }
    }
}

protocol ValidateCurrentUser: FirebaseInterface {
    func validateCurrentUser() -> Bool
}

extension ValidateCurrentUser {
    func validateCurrentUser() -> Bool {
        print("Here is the current user: \(firebaseAuth.currentUser?.email)")
        return firebaseAuth.currentUser == nil
    }
}

extension FirebaseInterface {
    var firebaseAuth: Auth {
        FirebaseAuth.Auth.auth()
    }
}

extension RegisterUserInterface {
    func registerUser(email: String,
                      password: String,
                      completion: @escaping (AuthDataResult) -> (),
                      errorHandler: @escaping (String) -> ()?) {
        firebaseAuth.createUser(withEmail: email, password: password) { result, error in
            guard let result, error == nil else {
                if let error {
                    errorHandler(error.localizedDescription)
                }
                return
            }
            completion(result)
        }
    }
    
    func signIn(with email: String,
                and password: String,
                completion: @escaping (AuthDataResult) -> (),
                errorHandler: @escaping (String) -> ()?) {
        firebaseAuth.signIn(withEmail: email, password: password) { result , error in
            guard let result, error == nil else {
                if let error {
                    errorHandler(error.localizedDescription)
                }
                return
            }
            completion(result)
        }
    }
}
