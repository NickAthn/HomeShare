//
//  ReviewsViewModel.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 4/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ReviewsViewModel: ObservableObject {
    let profile: Profile
    let isViewOnly: Bool

    @Published var showAddReviewModal: Bool = false
    @Published var isLikePressed: Bool = false {
        willSet {
            if isDislikedPressed { isDislikedPressed = false }
        }
    }
    @Published var isDislikedPressed: Bool = false {
        willSet {
            if isLikePressed { isLikePressed = false }
        }
    }
    
    init(profile: Profile, isViewOnly: Bool) {
        self.profile = profile
        self.isViewOnly = isViewOnly
    }

}
