//
//  MessagingService.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 5/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase

class MessagingService: ObservableObject {
    static let shared = MessagingService()
    
    func sendMessage(from: Profile, to: Profile, message: Message) {
        fetchConverastions(for: from) { (conversations) in
//            for conv in conversations {
//                if conv.userIDs.contains(to.uid) {
//                    self.sendMessage(from: from, conversation: conv, message: message)
//                }
//            }
            let filteredConversation = conversations.filter { $0.userIDs.contains(to.uid) }
            if filteredConversation.isEmpty {
                // Create a new conversation
                let newConversation = Conversation(userIDs: [to.uid, from.uid])
                self.updateConversation(newConversation)
//                self.sendMessage(from: from, conversation: newConversation, message: message)
            } else {
                // Conversation already exists
//                self.sendMessage(from: from, conversation: filteredConversation.first!, message: message)
            }
        }
    }
    func createConversation(fromID: String, to: Profile, completion: @escaping (_ profile: Conversation?) -> Void) {
        fetchConverastions(for: to) { (conversations) in
            let filteredConversation = conversations.filter { $0.userIDs.contains(to.uid) }
            if filteredConversation.isEmpty {
                // Create a new conversation
                let newConversation = Conversation(userIDs: [fromID, to.uid])
                self.addReferanceToProfilesFor(newConversation)
                self.updateConversation(newConversation)
                completion(newConversation)
            } else {
                completion(filteredConversation.first)
            }
        }
    }
    
    
    
    
    func sendMessage(conversation: Conversation, message: Message) {
        var conv = conversation
        conv.lastMessage = message.content
        
        Database.database().reference(withPath: conv.messagesPath()).child(message.id).setValue(message.toData())
        updateConversation(conv)
    }
    
    func updateConversation(_ conversation: Conversation) {
        Database.database().reference(withPath: conversation.path()).setValue(conversation.toData())
    }
    func addReferanceToProfilesFor(_ conversation: Conversation) {
        for id in conversation.userIDs {
            FirebaseService.shared.fetchProfile(forUID: id) { (profile) in
                if var profile = profile {
                    if profile.conversations == nil {
                        profile.conversations = [conversation.id]
                    } else {
                        profile.conversations?.append(conversation.id)
                    }
                    FirebaseService.shared.update(profile: profile)
                }
            }
        }
    }
    
    
    func fetchConverastions(for profile: Profile, completion: @escaping (_ profile: [Conversation]) -> Void) {
        
        guard let conversationsIDS = profile.conversations else {
            completion([])
            return
        }
        for conversationID in conversationsIDS {
            var conversations: [Conversation] = []
            Database.database().reference(withPath: Conversation.pathFor(id: conversationID)).observe(.value) { (snapshot) in
                guard let snapshotValue = snapshot.value else {
                    return
                }
                
                do {
                    let conversation = try FirebaseDecoder().decode(Conversation.self, from: snapshotValue)
                    conversations.append(conversation)
                    completion(conversations)
                } catch {}
            }
        }
    }
    
    func fetch(conversation: Conversation, completion: @escaping (_ profile: Conversation?) -> Void) {
        Database.database().reference(withPath: conversation.path()).observe(.value) { (snapshot) in
            guard let snapshotValue = snapshot.value else {
                completion(nil)
                return
            }
            do {
                let conversation = try FirebaseDecoder().decode(Conversation.self, from: snapshotValue)
                completion(conversation)
            } catch {
                completion(nil)
            }


        }
    }
    
    func fetchMessages(from conversation: Conversation, completion: @escaping (_ profile: [Message]?) -> Void) {
        var messages: [Message] = []
        Database.database().reference(withPath: conversation.messagesPath()).observe(.value) { (snapshot) in
            for child in snapshot.children.allObjects {
                let snap = child as! DataSnapshot
                guard let snapValue = snap.value else {
                    return
                }
                
                do {
                    let message = try FirebaseDecoder().decode(Message.self, from: snapValue)
                    messages.append(message)
                    completion(messages)
                } catch {
                   
                }
            }
        }
    }
}
