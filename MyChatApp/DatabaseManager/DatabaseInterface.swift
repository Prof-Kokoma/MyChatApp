//
//  DatabaseInterface.swift
//  MyChatApp
//
//  Created by Prof_K on 29/07/2023.
//

import Foundation
import FirebaseDatabase

protocol DatabaseInterface {
    var database: DatabaseReference { get }
}

extension DatabaseInterface {
    var database: DatabaseReference {
        Database.database().reference()
    }
    
    func userEmailExist(email: String, completion: @escaping (Bool) -> ()) {
        print("email is here: \(email)")
        database.child(email).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func createNewUser(with userData: ChatAppUser) {
        database.child(userData.email).setValue([
            "first_name": userData.firstName,
            "last_name": userData.lastName
        ]) { err, ref in
            guard err == nil else { return }
            print("I dont know what this is: \(ref.url) <==> \(ref.root)")
        }
    }
}


struct ChatAppUser: Codable {
    let firstName: String
    let lastName: String
    let email: String
//    let profilePicUrl: String
}
