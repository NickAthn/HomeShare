//
//  ProfileEditViewModel.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 30/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import Combine

class ProfileEditViewModel: ObservableObject {

    // MARK: - OUTPUT
//    @Published var selectedGuestStatus: GuestStatus = self.p
    @Published var profile: Profile = Profile.templateProfile
    @Published var statusPickerSelection = 0
    
    init() {
        fetchProfile()
    }
    func fetchProfile() {
        FirebaseService.shared.fetchProfileForCurrentUser { profile in
            if let profile = profile {
                self.profile = profile
                self.statusPickerSelection = profile.guestStatus.rawValue
                
            }
        }
    }
    
    func saveProfileChanges() {
        profile.guestStatus = GuestStatus.allCases[statusPickerSelection]
        FirebaseService.shared.stopFetching(profile: profile)
        FirebaseService.shared.update(profile: self.profile) { success in}
    }
}
