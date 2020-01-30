//
//  Profile.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 26/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase

enum SleepingArrangments: String, Codable {
    case
    privateRoom,
    publicRoom,
    sharedRoom,
    sharedSleepingSurface
}

enum GuestStatus: String, CaseIterable, Codable {
    case
    accepting,
    maybeAccepting,
    notAccepting,
    meetUp
}

struct Profile: FirebaseModal {
    var uid: String
    var firstName: String
    var lastName: String
    
    var guestStatus: GuestStatus = .accepting
    
    var home: Home
    
    var description: String = ""
    var havePets: Bool? = nil
    var haveChildren: Bool? = nil
    var smoker: Bool? = nil
    
    func toData()-> Any {
        return try! FirebaseEncoder().encode(self)
    }
    func path() -> String {
        return Profile.pathFor(uid: self.uid)
    }
    
    static func pathFor(uid: String) -> String {
        return [FirebasePaths.profiles.rawValue, uid].joined(separator: FirebasePathSeparator)
    }
}

struct Home: Codable {
    var address: String
    
    var maxGuests: Int? = nil
    var petsAllowed: Bool? = nil
    var smokingAllowed: Bool? = nil
    var kidFriendly: Bool? = nil
    var wheelChairAccessible: Bool? = nil
    var sleepingArrangments: SleepingArrangments? = nil
    
    var receiveSameDayRequests: Bool? = nil
}
