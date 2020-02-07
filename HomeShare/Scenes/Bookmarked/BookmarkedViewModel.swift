//
//  BookmarkedViewModel.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 7/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation

class BookmarkedViewModel: ObservableObject {
    var profile: Profile
    init(_ profile: Profile) {
        self.profile = profile
        self.fetchProfiles()
    }
    
    @Published var displayedProfiles: [Profile] = []
    
    func fetchProfiles() {
        if let bookmarkedIDS = profile.bookmarkedProfiles {
            for profileID in bookmarkedIDS {
                FirebaseService.shared.fetchProfile(forUID: profileID) { (profile) in
                    if let profile = profile {
                        self.displayedProfiles.append(profile)
                    }
                }
            }
        }
    }
}
