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
    static let shared = FirDatabaseManager()

    let ref = Database.database().reference().root
    
    
    func createUser(withEmail: String, id: String) {
        ref.child("users").child(id).setValue(withEmail)
    }
    func deleteUser(withID: String) {
        let userRef = ref.child("user").child(withID)
        userRef.removeValue() { error, _ in
            print("🐞 FirDatabase Error: \(String(describing: error))")
        }
    }
}
