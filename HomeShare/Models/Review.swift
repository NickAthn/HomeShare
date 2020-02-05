//
//  Review.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 4/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import CodableFirebase

struct Review: Codable, Identifiable, Hashable {
    var id: String = ""
    var reviewdID: String
    var reviewerID: String
    
    var isLiked: Bool = false
    var title: String? = ""
    var description: String? = ""
    
    init(from: String, to: String) {
        reviewerID = from
        reviewdID = to
    }
    
    func toData()-> Any {
        return try! FirebaseEncoder().encode(self)
    }
    
    func path() -> String {
        return Review.pathFor(id: self.id)
    }
    static func pathFor(id: String) -> String {
        return [FirebasePaths.reviews.rawValue, id].joined(separator: FirebasePathSeparator)
    }
    

}
