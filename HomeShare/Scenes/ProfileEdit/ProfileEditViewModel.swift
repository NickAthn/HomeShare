//
//  ProfileEditViewModel.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 30/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import Combine
import UIKit

class ProfileEditViewModel: ObservableObject {

    // MARK: - OUTPUT
//    @Published var selectedGuestStatus: GuestStatus = self.p
    @Published var profile: Profile = Profile.templateProfile
    @Published var statusPickerSelection = 0
    
    // Generic Bool to be used on many view to dismish them when called
    @Published var isActive = false
    @Published var showImagePicker = false
    
    var initialImage: UIImage!
    @Published var profileImage: UIImage? = UIImage(named: "genericProfileImage")
    
    init() {
        fetchProfile()
    }
    func fetchProfile() {
        FirebaseService.shared.fetchProfileForCurrentUser { profile in
            if let profile = profile {
                self.profile = profile
                self.statusPickerSelection = profile.guestStatus.rawValue
                self.loadProfileImage()
            }
        }
    }
    func loadProfileImage() {
        if profile.profileImageURL != "" {
            FirStorageManager.shared.download(imageWithURL: profile.profileImageURL) { (image) in
                if image != nil {
                    DispatchQueue.main.async {
                        self.profileImage = image
                    }
                    self.initialImage = image
                } else {
                    self.initialImage = self.profileImage
                }
                }
        }
    }
    
    func uploadProfileImage(completion: @escaping ()->Void) {
        if initialImage != profileImage {
            FirStorageManager.shared.upload(profileImage!) { (url) in
                self.profile.profileImageURL = url!.absoluteString
                completion()
            }
        } else {
            completion()
        }
    }
    func saveProfileChanges() {
        print(profile.description)
        profile.guestStatus = GuestStatus.allCases[statusPickerSelection]
        FirebaseService.shared.stopFetching(profile: profile)
        uploadProfileImage() {
            FirebaseService.shared.setUserLocation(address: self.profile.home.address)
            FirebaseService.shared.update(profile: self.profile) { success in}
        }
    }
}
