//
//  Accommodation.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 13/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import Firebase

struct Accommodation: Identifiable {
    var id: String
    var address: String
    var imageURL: String
    var ownerID: String
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let address = value["address"] as? String,
            let ownerID = value["userID"] as? String,
            let imageURL = value["imageURL"] as? String
            else {
                return nil
            }
      
        self.id = snapshot.key
        self.address = address
        self.ownerID = ownerID
        self.imageURL = imageURL
    }
}
