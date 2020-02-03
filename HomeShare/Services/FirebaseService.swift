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
                self.update(user: self.session!) // Updates the db entity
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
    
    func fetchProfile(forUID: String, completion: @escaping (_ profile: Profile?) -> Void) {
        let profilePath = Profile.pathFor(uid: forUID)
        Database.database().reference(withPath: profilePath).observeSingleEvent(of: .value) { (snapshot) in
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
    
    func update(profile: Profile) {
        let profileData = profile.toData()
        Database.database().reference(withPath: profile.path()).setValue(profileData)
    }
    
    func fetchUser(forUID: String, completion: @escaping (_ profile: User?) -> Void ) {
        let userPath = User.pathFor(uid: forUID)
        Database.database().reference(withPath: userPath).observeSingleEvent(of: .value) { (snapshot) in
            guard let snapshotValue = snapshot.value else {
                completion(nil)
                return
            }
            
            do {
                let user = try FirebaseDecoder().decode(User.self, from: snapshotValue)
                completion(user)
            } catch {
                completion(nil)
            }
        }
    }
    
    func update(user: User) {
        let userData = user.toData()
        Database.database().reference(withPath: user.path()).setValue(userData)
    }
    
    func setUserLocation(address: Address) {
        let geofireRef = Database.database().reference().child(FirebasePaths.geoHash.rawValue)
        let geoFire = GeoFire(firebaseRef: geofireRef)
        let locationService = LocationService()
        locationService.getLocationFrom(address: address) { location in
            if let location = location {
                print(location)
                geoFire.setLocation(location, forKey: self.session!.uid)
            }
        }
    }
    func getProfiles(for address: String, completion: @escaping ([Profile])->Void){
        var foundProfiles: [Profile] = []
        let geofireRef = Database.database().reference().child(FirebasePaths.geoHash.rawValue)
        let geoFire = GeoFire(firebaseRef: geofireRef)
        let locationService = LocationService()
        locationService.searchLocationgWith(addressString: address) { location in
            if let location = location {
                let center = location
                // Query locations at [37.7832889, -122.4056973] with a radius of 30km
                var circleQuery = geoFire.query(at: center, withRadius: 30)
                
                // Query location by region
                let span =  MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
                let region = MKCoordinateRegion(center: center.coordinate, span: span)
                let regionQuery = geoFire.query(with: region)
                
                var _ = circleQuery.observe(.keyEntered, with: { (key: String!, location: CLLocation!) in
                    print("Key '\(String(describing: key))' entered the search area and is at location '\(String(describing: location))'")
                    self.fetchProfile(forUID: key) { (profile) in
                        if let profile = profile {
                            foundProfiles.append(profile)
                            completion(foundProfiles)
                        }
                    }
                })

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
