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
import SwiftUI

enum VerificationStatus: Int, CustomStringConvertible, Codable {
    case
    verified = 1,
    notVerified = 0
    
    var description: String {
      get {
        switch self {
          case .verified:
            return "Account Verified"
          case .notVerified:
            return "Not Verified"
        }
      }
    }
    
    var color: Color {
        get {
            switch self {
                case .verified: return Color.green
                case .notVerified: return Color.red
            }
        }
    }
    
    var image: Image {
        get {
            switch self {
                case .verified: return Image(systemName: "checkmark.seal.fill")
                case .notVerified: return  Image(systemName: "xmark.seal.fill")
            }
        }
    }

    init(_ isVerified: Bool) {
        switch isVerified {
            case true: self = .verified
            case false: self = .notVerified
        }
    }
}

struct User: Codable {
    let uid: String
    let email: String?
    let displayName: String?
    
    let verificationStatus: VerificationStatus

    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
        self.verificationStatus = .notVerified
    }
    
    init(authData: Firebase.User) {
        uid = authData.uid
        email = authData.email!
        displayName = authData.displayName
        verificationStatus = .init(authData.isEmailVerified)
        //verificationStatus = VerificationStatus(rawValue: authData.isEmailVerified.hashValue)!
    }
    
    func toData()-> Any {
        return try! FirebaseEncoder().encode(self)
    }
    func path() -> String {
        return User.pathFor(uid: self.uid)
    }
    
    static func pathFor(uid: String) -> String {
        return [FirebasePaths.users.rawValue, uid].joined(separator: FirebasePathSeparator)
    }
    
    static var templateProfile = User(uid: "", displayName: "", email: "")
}
