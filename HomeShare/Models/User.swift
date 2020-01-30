//
//  User.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 21/12/19.
//  Copyright © 2019 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase

struct User: Codable {
    let uid: String
    let email: String?
    let displayName: String?

    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
    
    init(authData: Firebase.User) {
        uid = authData.uid
        email = authData.email!
        displayName = authData.displayName
    }
    
    func toData()-> Any {
        return try! FirebaseEncoder().encode(self)
    }

}
