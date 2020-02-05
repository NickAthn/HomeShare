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
    
    @Published var guestStatusMessage: String = ""
    @Published var profileImage: UIImage = UIImage(named: "genericProfileImage")!

    @Published var profile: Profile = Profile.templateProfile
    @Published var currentUser: User = User.templateProfile

    @Published var isViewOnly: Bool


    
    // Initilise with the logged in user
    init(){
        isViewOnly = false
        setup()
    }
    // Initilise with the given user
    init(profile: Profile){
        self.profile = profile
        isViewOnly = true
        setup()
    }
    
    func setup() {
        if isViewOnly {
            self.loadProfileImage()
            self.fetchUser()
        } else {
            currentUser = FirebaseService.shared.session!
            fetchProfile()
        }
    }
    
    // Fetch Current User Profile
    func fetchProfile() {
        FirebaseService.shared.fetchProfileForCurrentUser { profile in
            if let profile = profile {
                self.profile = profile
                self.loadProfileImage()
                print(profile.description)
            }
        }
    }
        
    // Load Image with the store profile property
    func loadProfileImage() {
        if profile.profileImageURL != "" {
            FirStorageManager.shared.download(imageWithURL: profile.profileImageURL) { (image) in
                if image != nil {
                    DispatchQueue.main.async {
                        if let image = image {
                            self.profileImage = image
                        }
                    }
                }
            }
        }
    }
    
    // Fetch User entity
    func fetchUser() {
        FirebaseService.shared.fetchUser(forUID: profile.uid) { (user) in
            if let user = user {
                self.currentUser = user
            }
        }
    }
}
