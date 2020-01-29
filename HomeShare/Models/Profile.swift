//
//  Profile.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 26/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import Firebase

//enum SleepingArrangments: String {
//    case
//    privateRoom,
//    publicRoom,
//    sharedRoom,
//    sharedSleepingSurface
//}
//
//enum GuestStatus: String {
//    case
//    accepting,
//    maybeAccepting,
//    motAccepting,
//    meetUp
//}
//
//class Profile: Identifiable {
//    let id: String
//    let firstName: String
//    let lastName: String
//    
//    let acceptingGuests: GuestStatus
//    
//    let home: Home
//    
//    let description: String?
//    let havePets: Bool?
//    let haveChildren: Bool?
//    let smoker: Bool?
//    
//    init?(snapshot: DataSnapshot) {
//        guard
//            let value = snapshot.value as? [String: Any],
//            let id = value["userID"] as? String,
//            let firstName = value["firstName"] as? String,
//            let lastName = value["lastName"] as? String,
//            let acceptingGuests = value["acceptingGuests"] as? GuestStatus,
//            let description = value["description"] as? String,
//            let havePets = value["havePets"] as? Bool,
//            let haveChildren = value["haveChildren"] as? Bool,
//            let smoker = value["smoker"] as? Bool,
//            let home = value["home"] as? Home
//            else {
//                return nil
//            }
//        
//        self.id = id
//        self.firstName = firstName
//        self.lastName = lastName
//        self.acceptingGuests = acceptingGuests
//        self.description = description
//        self.havePets = havePets
//        self.haveChildren = haveChildren
//        self.smoker = smoker
//        self.home = home
//    }
//
//}
//
//class Home {
//    let address: String
//    
//    let maxGuests: Int?
//    let petsAllowed: Bool?
//    let smokingAllowed: Bool?
//    let kidFriendly: Bool?
//    let wheelChairAccessible: Bool?
//    let sleepingArrangments: SleepingArrangments?
//    
//    let receiveSameDayRequests: Bool?
//}
