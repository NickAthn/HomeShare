//
//  FirebaseService.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 30/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase
import GeoFire

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
        Auth.auth().currentUser?.delete() { error in
            if error != nil {
                print(error as Any)
            }
        }
    }
    
    func fetchProfileForCurrentUser(completion: @escaping (_ profile: Profile?) -> Void) {
        guard let currentUser = session else {
            completion(nil)
            return
        }
        let profilePath = Profile.pathFor(uid: currentUser.uid)
        Database.database().reference(withPath: profilePath).observe(.value) { (snapshot) in
            guard let snapshotValue = snapshot.value else {
                completion(nil)
                return
            }
            
            do {
                let profile = try FirebaseDecoder().decode(Profile.self, from: snapshotValue)
                completion(profile)
            } catch {
                completion(nil)
            }
        }
    }
    
    func stopFetching(profile: Profile) {
        Database.database().reference(withPath: profile.path()).removeAllObservers()
    }
    
    func update(profile: Profile, completion: @escaping (_ success: Bool)-> Void) {
        let profileData = profile.toData()
        print(profile.path())
        
        Database.database().reference(withPath: profile.path()).setValue(profileData)
    }
    func setUserLocation(address: Address) {
        let geofireRef = Database.database().reference().child(FirebasePaths.geoHash.rawValue)
        let geoFire = GeoFire(firebaseRef: geofireRef)
        let locationService = LocationService()
        locationService.getLocationFrom(address: address) { location in
            if let location = location {
                print(location)
                geoFire.setLocation(CLLocation(latitude: 37.7853889, longitude: -122.4056973), forKey: self.session!.uid)
            }
        }
    }
    
    
    // MARK: - Error Handling
    func getErrorDescription(_ error: Error)->String {
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            print("🚫", errorCode.errorMessage)
            return errorCode.errorMessage
        }
        return ""
    }



}

//// MARK: - Authenitcation/User
//func createUser(withEmail: String, id: String) {
//    baseRef.child("users").child(id).setValue(withEmail)
//}
//
//func deleteUser(withID: String) {
//    let userRef = baseRef.child("users").child(withID)
//    userRef.removeValue() { error, _ in
//        print("🐞 FirDatabase Error: \(String(describing: error))")
//    }
//}
