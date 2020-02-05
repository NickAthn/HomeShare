//
//  Message.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 5/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import CodableFirebase

struct Message: Codable, Hashable {
    var id: String = UUID().uuidString
    var content: String
    var timestamp = Int(Date().timeIntervalSince1970)
    var ownerID: String?
    
    func toData()-> Any {
        return try! FirebaseEncoder().encode(self)
    }
}

struct MessageVault: Codable {
    var conversationID: String
    var messages: [Message]
    
    func toData()-> Any {
        return try! FirebaseEncoder().encode(self)
    }
}
