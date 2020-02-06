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
    @Published var statusPickerSelection = 0 {
        didSet {
            profile.guestStatus = GuestStatus.allCases[statusPickerSelection]
        }
    }
    
    // Generic Bool to be used on many view to dismish them when called
    @Published var isActive = false
    @Published var showImagePicker = false
    
    var initialImage: UIImage!
    @Published var profileImage: UIImage? = UIImage(named: "genericProfileImage")
    // Date Picker
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    @Published var birthDate = Date() {
        didSet {
            profile.yearBorn = self.birthDate.timeIntervalSince1970
        }
    }

    // Gender Picker
    @Published var genderPickerSelection = 3 {
        didSet {
            profile.gender = Gender.allCases[genderPickerSelection]
        }
    }
    
    //Languge
    @Published var languageInfo: String = "" {
        didSet {
            profile.languageInfo = self.languageInfo
        }
    }
    
    // Home
    @Published var maxGuests: Int = 0 {
        didSet {
            profile.home.maxGuests = self.maxGuests
        }
    }
    @Published var petsAllowed: Bool = false {
        didSet {
            profile.home.petsAllowed = self.petsAllowed
        }
    }
    @Published var smokingAllowed: Bool = false {
        didSet {
            profile.home.smokingAllowed = self.smokingAllowed
        }
    }
    @Published var kidFriendly: Bool = false {
        didSet {
            profile.home.kidFriendly = self.kidFriendly
        }
    }
    @Published var wheelChairAccessible: Bool = false {
        didSet {
            profile.home.wheelChairAccessible = self.wheelChairAccessible
        }
    }
    @Published var sleepingPickerSelection = 0 {
        didSet {
            profile.home.sleepingArrangments = SleepingArrangments.allCases[sleepingPickerSelection]
        }
    }
    @Published var receiveSameDayRequests: Bool = false {
        didSet {
            profile.home.receiveSameDayRequests = self.receiveSameDayRequests
        }
    }


    init() {
        fetchProfile()
    }
    func fetchProfile() {
        FirebaseService.shared.fetchProfileForCurrentUser { profile in
            if let profile = profile {
                self.profile = profile
                self.statusPickerSelection = profile.guestStatus.rawValue
                self.birthDate = profile.yearBorn?.toDate() ?? Date()
                self.genderPickerSelection = profile.gender?.rawValue ?? 3
                self.languageInfo = profile.languageInfo ?? ""
                
                // Set home info
                self.maxGuests = profile.home.maxGuests ?? 0
                self.petsAllowed = profile.home.petsAllowed ?? false
                self.smokingAllowed = profile.home.smokingAllowed ?? false
                self.kidFriendly = profile.home.kidFriendly ?? false
                self.wheelChairAccessible = profile.home.wheelChairAccessible ?? false
                self.sleepingPickerSelection = profile.home.sleepingArrangments?.rawValue ?? 4
                self.receiveSameDayRequests = profile.home.receiveSameDayRequests ?? false
                
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
        FirebaseService.shared.stopFetching(profile: profile)
        uploadProfileImage() {
            FirebaseService.shared.setUserLocation(address: self.profile.home.address)
            FirebaseService.shared.update(profile: self.profile)
        }
    }
}
