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
    
    @Published var isViewOnly: Bool
    
    init(){
        isViewOnly = false
        fetchProfile()
    }
    init(profile: Profile){
        self.profile = profile
        isViewOnly = true
    }
    
    func fetchProfile() {
        FirebaseService.shared.fetchProfileForCurrentUser { profile in
            if let profile = profile {
                self.profile = profile
                print(profile.description)
            }
        }
    }
        
}
