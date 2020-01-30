//
//  FirebaseService.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 30/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService: ObservableObject {
    static let shared = FirebaseService()
    
    @Published var session: User?
    var handle: AuthStateDidChangeListenerHandle?

    // MARK: - Session Listener
    func startSessionListener() {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                print("🐞 Got user: \(user)")
                guard let authUser = auth.currentUser else { return }
                self.session = User(authData: authUser)
            } else {
                self.session = nil
            }
        }
    }
    func stopSessionListener() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    // MARK: - Authentication Methods
    func createUser(withEmail: String, password: String, completion: @escaping AuthDataResultCallback){
        Auth.auth().createUser(withEmail: withEmail, password: password) { authResult, error in
            if error == nil {
                completion(authResult, nil)
            } else {
                completion(nil, error)
                print("🐞 Firebase Error: \(String(describing: error))")
            }
        }
        
    }

    func signIn(withEmail: String, password: String, completion: @escaping AuthDataResultCallback){
        Auth.auth().signIn(withEmail: withEmail, password: password) { authResult, error in
            if error == nil {
               completion(authResult, nil)
            } else {
                completion(nil, error)
                print("🐞 Firebase Error: \(String(describing: error))")
            }
        }
    }
    
    func singIn(withCredential: AuthCredential, completion: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(with: withCredential) { authResult, error in
            if error == nil {
               completion(authResult, nil)
            } else {
                completion(nil, error)
                print("🐞 Firebase Error: \(String(describing: error))")
            }
        }
    }
    
    func signOut() {
        do {
            try? Auth.auth().signOut()
            self.session = nil
        }
    }
    
    func deleteAccount() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        Auth.auth().currentUser?.delete() { error in
            if error != nil {
                print(error as Any)
            } else {
                FirDatabaseManager.shared.deleteUser(withID: userID)
            }
        }
    }
    
    // Error Handling
    func getErrorDescription(_ error: Error)->String {
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            print("🚫", errorCode.errorMessage)
            return errorCode.errorMessage
        }
        return ""
    }



}
