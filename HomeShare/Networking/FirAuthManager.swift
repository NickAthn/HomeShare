//
//  NetworkManager.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 21/12/19.
//  Copyright © 2019 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI
import Combine
import Firebase
import GoogleSignIn


class FirAuthManager: ObservableObject {
    static let shared = FirAuthManager()
    
    var session: User? { didSet { self.didChange.send(self) }}
    var didChange = PassthroughSubject<FirAuthManager, Never>()
    var handle: AuthStateDidChangeListenerHandle?
    
    // Start the session listener
    func listen() {
    
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                print("🐞 Got user: \(user)")
                self.session = User(
                    uid: user.uid,
                    displayName: user.displayName,
                    email: user.email
                )
            } else {
                // if we don't have a user, set our session to nil
                self.session = nil
            }
        }
    }
    
    // Stop the session listener
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    // MARK: - User Authentication
    func createUser(withEmail: String, password: String, completion: @escaping AuthDataResultCallback){
        Auth.auth().createUser(withEmail: withEmail, password: password) { authResult, error in
            if error == nil {
                // Registering the new user on the database with his uuid
                FirDatabaseManager.shared.createUser(withEmail: withEmail, id: (authResult?.user.uid)!)
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
    
    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
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
    
    // User Information Change Requests
    func updateProfile(imageURL: URL){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.photoURL = imageURL
        changeRequest?.commitChanges { (error) in }
    }
    func updateProfile(displayName: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = displayName
        changeRequest?.commitChanges { (error) in }
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
