//
//  Review.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 4/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import CodableFirebase

struct Review: Codable {
    var id: String = ""
    var reviewerID: String
    
    var isLiked: Bool = false
    var title: String? = ""
    var description: String? = ""
        
    func toData()-> Any {
        return try! FirebaseEncoder().encode(self)
    }

}
