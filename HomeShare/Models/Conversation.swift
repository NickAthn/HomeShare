//
//  Conversation.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 5/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import CodableFirebase

struct Conversation: Codable {
    
    var id: String = UUID().uuidString
    var userIDs = [String]()
    var timestamp = Int(Date().timeIntervalSince1970)
    var lastMessage: String?
    
    init(userIDs: [String]) {
        self.userIDs = userIDs
    }
    
    func toData()-> Any {
        return try! FirebaseEncoder().encode(self)
    }
    
    func path() -> String {
        return Conversation.pathFor(id: self.id)
    }
    
    func messagesPath()->String {
        return Conversation.messagesPathFor(id: self.id)
    }
    
    static func pathFor(id: String) -> String {
        return [FirebasePaths.conversations.rawValue, id].joined(separator: FirebasePathSeparator)
    }
    
    static func messagesPathFor(id: String) -> String {
        return [FirebasePaths.messages.rawValue, id].joined(separator: FirebasePathSeparator)
    }

}
