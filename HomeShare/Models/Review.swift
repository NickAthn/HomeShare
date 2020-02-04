//
//  Review.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 4/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation

struct Review: Codable {
    var isLiked: Bool
    var title: String?
    var description: String?
}
