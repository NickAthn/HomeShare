//
//  FirDatabaseManager.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 14/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI
import Combine
import Firebase

class FirDatabaseManager: ObservableObject {
    // Singleton
    static let shared = FirDatabaseManager()

    // MARK: - Database Reference's
    let baseRef = Database.database().reference().root
    var userRef: DatabaseReference {
        return baseRef.child("users")
    }
    var accRef: DatabaseReference {
        return baseRef.child("accommodations")
    }
    // MARK: - Handles
    var accRefHandle: DatabaseHandle!
    
    func removeAllActiveObservers() {
        accRef.removeObserver(withHandle: accRefHandle)
    }
    
        
    
    
    // MARK: - Authenitcation/User
    func createUser(withEmail: String, id: String) {
        baseRef.child("users").child(id).setValue(withEmail)
    }
    
    func deleteUser(withID: String) {
        let userRef = baseRef.child("users").child(withID)
        userRef.removeValue() { error, _ in
            print("🐞 FirDatabase Error: \(String(describing: error))")
        }
    }
}
