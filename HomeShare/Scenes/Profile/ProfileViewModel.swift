//
//  ProfileViewModel.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 29/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    
    // MARK: - OUTPUT
    @Published var guestStatusMessage: String = ""
    @Published var profile: Profile = Profile.templateProfile

    func fetchProfile() {
        FirebaseService.shared.fetchProfileForCurrentUser { profile in
            if let profile = profile {
                self.profile = profile
            }
        }
    }
    
    func update(guestStatus: GuestStatus?){
        switch guestStatus {
            case .accepting:
                guestStatusMessage = "Accepting Guests"
            case .maybeAccepting:
                guestStatusMessage = "Maybe Accepting Guests"
            case .meetUp:
                guestStatusMessage = "Meet up"
            case .notAccepting:
                guestStatusMessage = "Not Accepting Guests"
            case .none:
                guestStatusMessage = "Not Defined"
        }
    }
    
}
