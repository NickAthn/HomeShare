//
//  AccountViewModel.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 9/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI
import Combine

class AccountViewModel: ObservableObject {
    let didChange = PassthroughSubject<Void, Never>()

    // MARK: OUTPUT
    @Published var isDeleteAlertShown = false

    // MARK: NAVIGATION
    @Published var showHostingView = false
    @Published var showProfileView = false

    @Published var profileImage = UIImage(named: "genericProfileImage")!
    @Published var profile: Profile = Profile.templateProfile
    init() {
        self.fetchProfile()
    }
    func signOut() {
        FirebaseService.shared.signOut()
    }
    
    func fetchProfile() {
        FirebaseService.shared.fetchProfileForCurrentUser { profile in
            if let profile = profile {
                self.profile = profile
                self.loadProfileImage()
                print(profile.description)
            }
        }
    }

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

    func initiateDeleteSequence() {
        isDeleteAlertShown = true
    }
    func deleteAccount() {
        FirebaseService.shared.deleteAccount()
    }
}
