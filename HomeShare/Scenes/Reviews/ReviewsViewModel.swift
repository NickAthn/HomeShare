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

    var reviews: [Review] = []
    var likes: Int  {
        get {
            reviews.filter { $0.isLiked }.count
        }
    }
    var dislikes: Int  {
        get {
            reviews.filter { !$0.isLiked }.count
        }
    }

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
    var likePercentage: Int {
        get {
            if reviews.isEmpty {
                return 0
            }
            return Int(Double(likes)/Double(reviews.count)*100)
        }
    }
    
    init(profile: Profile, isViewOnly: Bool, reviews: [Review]) {
        self.profile = profile
        self.isViewOnly = isViewOnly
        self.reviews = reviews
    }
}
