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
    // View Only
    @Published var isBookmarked: Bool = false
    var bookmarkImage: Image {
        get {
            isBookmarked ? Image(systemName: "heart.fill") : Image(systemName: "heart")
        }
    }
    var bookmarkText: String {
        get {
            isBookmarked ? "Unsave Profile" : "Save Profile"
        }
    }
    var languageInfo: String {
        get {
            return profile.languageInfo ?? ""
        }
    }
    var genderAgeText: String {
        get {
            var components: [String] = []
            if let gender = profile.gender {
                if gender != .unspecified {
                    components.append("\(gender.description)")
                }
            }
            if let yearsSince = profile.yearBorn?.getYearsSinceFromUTC() {
                components.append("\(yearsSince) years old")
            }
            
            if components.isEmpty {
                return ""
            }
            
            return components.joined(separator: ", ")
        }
    }
    
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
            self.setBookmarkStatus()
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
    
    // View Only methods
    func bookmarkProfile() {
        guard var activeProfile = FirebaseService.shared.sessionProfile else { return }
        if isBookmarked { // Unbookmark
            activeProfile.bookmarkedProfiles?.removeAll{ $0 == self.profile.uid }
            FirebaseService.shared.update(profile: activeProfile)
            self.isBookmarked = false
        } else {
            if activeProfile.bookmarkedProfiles != nil {
                activeProfile.bookmarkedProfiles?.append(self.profile.uid)
            } else {
                activeProfile.bookmarkedProfiles = [self.profile.uid]
            }
            FirebaseService.shared.update(profile: activeProfile)
            self.isBookmarked = true
        }
    }
    func setBookmarkStatus() {
        guard var activeProfile = FirebaseService.shared.sessionProfile else { return }
        if let bookmarks = activeProfile.bookmarkedProfiles {
            if bookmarks.contains(profile.uid) {
                self.isBookmarked = true
            } else {
                self.isBookmarked = false
            }
        }
    }
}
