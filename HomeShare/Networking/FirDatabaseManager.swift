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
    
    // MARK: - Accomodations Functions
    func createAccommodation(imageURL: URL, address: String) {
        let currentUserID = FirAuthManager.shared.session?.uid
        let accRef = baseRef.child("accommodations")
        let accKey = accRef.childByAutoId().key
        let accommodation =
            ["userID": currentUserID,
             "address": address,
             "imageURL": imageURL.absoluteString
        ]
        
        accRef.child(accKey!).setValue(accommodation)
    }
    
    func fetchAccommodations(completion: @escaping (_ result: [Accommodation]) -> Void) {
        var allAccom: [Accommodation] = []
        // In case of multiple observers it removes the previous one to avoid memmory leaks
       
        accRefHandle = accRef.observe(.value) { (snapshot) in
            allAccom.removeAll()
            for child in snapshot.children {
                if let childSnap = child as? DataSnapshot {
                    if let newAcc = Accommodation(snapshot: childSnap) {
                        allAccom.append(newAcc)
                    }
                }
            }
            completion(allAccom)
        }
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
