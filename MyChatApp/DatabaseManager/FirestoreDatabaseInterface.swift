//
//  FirestoreDatabaseInterface.swift
//  MyChatApp
//
//  Created by Prof_K on 29/07/2023.
//

import Foundation
import FirebaseFirestore

protocol FirestoreDatabaseInterface {
    var database: Firestore { get }
}

//MARK: - Account management
extension FirestoreDatabaseInterface {
    var database: Firestore {
        Firestore.firestore()
    }
    
    /// Insert new user into Firestore database
    func createNewUser(id: String, userData: [String: Any]) {
        database.collection("Users").document(id).setData(userData, merge: true) { error in
            guard error == nil else {
                return
            }
            print("User created successfully")
        }
    }
}
