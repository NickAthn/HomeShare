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
import SwiftUI

enum SleepingArrangments: String, Codable {
    case
    privateRoom,
    publicRoom,
    sharedRoom,
    sharedSleepingSurface
}

enum GuestStatus: Int, CaseIterable, Codable {
    case
    accepting,
    maybeAccepting,
    notAccepting,
    meetUp
}

extension GuestStatus {
    func getDescription() -> String {
        switch self {
            case .accepting: return "Accepting Guests"
            case .maybeAccepting: return "Maybe Accepting Guests"
            case .meetUp: return "Meet up"
            case .notAccepting: return "Not Accepting Guests"
        }
    }
    func getColor() -> Color {
        switch self {
            case .accepting: return .green
            case .maybeAccepting: return .secondary
            case .meetUp: return .yellow
            case .notAccepting: return .red
        }

    }
}

struct Profile: FirebaseModal {

    var uid: String
    var firstName: String
    var lastName: String
    
    var profileImageURL: String = ""
    
    var guestStatus: GuestStatus = .accepting
    
    var home: Home = .init()
    
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
    
    static var templateProfile = Profile(uid: "loading... ", firstName: "loading... ", lastName: "loading... ")
    
}
// Conforming to hashable and Equatable protocol
extension Profile: Hashable {
    static func == (lhs: Profile, rhs: Profile) -> Bool {
        return lhs.uid == rhs.uid ?  true : false
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
    }
}

struct Home: Codable {
    var address: Address = .init()
    
    var maxGuests: Int? = nil
    var petsAllowed: Bool? = nil
    var smokingAllowed: Bool? = nil
    var kidFriendly: Bool? = nil
    var wheelChairAccessible: Bool? = nil
    var sleepingArrangments: SleepingArrangments? = nil
    
    var receiveSameDayRequests: Bool? = nil
}
