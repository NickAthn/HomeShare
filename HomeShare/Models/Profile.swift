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
    motAccepting,
    meetUp
}

struct Profile: Codable {
    var id: String
    var firstName: String
    var lastName: String
    
    var guestStatus: GuestStatus = .accepting
    
    var home: Home
    
    var description: String?
    var havePets: Bool?
    var haveChildren: Bool?
    var smoker: Bool?
}

struct Home: Codable {
    var address: String
    
    var maxGuests: Int?
    var petsAllowed: Bool?
    var smokingAllowed: Bool?
    var kidFriendly: Bool?
    var wheelChairAccessible: Bool?
    var sleepingArrangments: SleepingArrangments?
    
    var receiveSameDayRequests: Bool?
}
