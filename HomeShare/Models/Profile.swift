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

enum SleepingArrangments: Int, Codable, CaseIterable, CustomStringConvertible {
    case
    privateRoom,
    publicRoom,
    sharedRoom,
    sharedSleepingSurface,
    unspecified
    
    var description: String {
        switch self {
            case .privateRoom: return "Private Room"
            case .publicRoom: return "Public Room"
            case .sharedRoom: return "Shared Room"
            case .sharedSleepingSurface: return "Shared Sleeping Surface"
            case .unspecified: return "Unspecified"

        }
    }

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

enum Gender: Int, Codable, CaseIterable, CustomStringConvertible {
    var description: String {
        switch self {
            case .female: return "Female"
            case .male: return "Male"
            case .unspecified: return "Unspecified"
        }
    }

    case
    male = 0,
    female = 1,
    unspecified = 2
}

struct Profile: FirebaseModal {

    var uid: String
    var firstName: String
    var lastName: String
    
    var profileImageURL: String = ""
    
    var guestStatus: GuestStatus = .accepting
    
    var home: Home = .init()
    var reviewIDS: [String]? = []
    var conversations: [String]? = []
    
    var description: String = ""
    var havePets: Bool? = nil
    var haveChildren: Bool? = nil
    var smoker: Bool? = nil
        
    var languageInfo: String? = ""
    var yearBorn: Double?
    var gender: Gender? = .unspecified
    let memberSince: Double? = Date().timeIntervalSince1970
    
    var verificationStatus: VerificationStatus?
    
    var bookmarkedProfiles: [String]? = []
    
    func toData()-> Any {
        return try! FirebaseEncoder().encode(self)
    }
    func path() -> String {
        return Profile.pathFor(uid: self.uid)
    }
    
    func getFullName() -> String {
        return "\(firstName) \(lastName)"
    }
    
    static func pathFor(uid: String) -> String {
        return [FirebasePaths.profiles.rawValue, uid].joined(separator: FirebasePathSeparator)
    }
    
    static var templateProfile = Profile(uid: "loading... ", firstName: "loading... ", lastName: "")
    
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
