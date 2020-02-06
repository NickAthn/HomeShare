//
//  HouseInformationViewModel.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 7/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation

class HouseInformationViewModel: ObservableObject {
    var home: Home
    init(home: Home) {
        self.home = home
    }
    var maxGuests: String {
        get {
            switch home.maxGuests {
                case .none: return "Ask User"
                case .some(0): return "Ask User"
                default: return "\(home.maxGuests!)"
            }
        }
    }
    
    var petsAllowed: String {
        get {
            switch home.petsAllowed {
                case true: return "Allowed"
                case false: return "Not Allowed"
                default: return "Ask User"
            }
        }
    }

    var smokingAllowed: String {
        get {
            switch home.smokingAllowed {
                case true: return "Allowed"
                case false: return "Not Allowed"
                default: return "Ask User"
            }
        }
    }
    var kidFriendly: String {
        get {
            switch home.kidFriendly {
                case true: return "Yes"
                case false: return "No"
                default: return "Ask User"
            }
        }
    }
    var wheelChairAccessible: String {
        get {
            switch home.wheelChairAccessible {
                case true: return "Yes"
                case false: return "No"
                default: return "Ask User"
            }
        }
    }
    
    var sleepingArrangments: String {
        get {
            if let sAR = home.sleepingArrangments {
                return sAR.description
            } else {
                return "Ask User"
            }
        }
    }

    var receiveSameDayRequests: String {
        get {
            switch home.receiveSameDayRequests {
                case true: return "Yes"
                case false: return "No"
                default: return "Ask User"
            }
        }
    }


}
