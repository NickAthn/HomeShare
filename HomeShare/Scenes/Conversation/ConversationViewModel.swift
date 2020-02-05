//
//  ConversationViewModel.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 5/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation

class ConversationViewModel: ObservableObject {
    var conversation: Conversation
    let toProfile: Profile
    @Published var messages: [Message] = []
    @Published var textFieldText: String = ""
    
//    init(_ conversation: Conversation) {
//        self.conversation = conversation
//    }
    init(to: Profile){
        conversation = Conversation(userIDs: [])
        self.toProfile = to
        createConversation()
        
    }
    
    func createConversation() {
        guard let currentUserID = FirebaseService.shared.session?.uid else { return }
        MessagingService.shared.createConversation(fromID: currentUserID, to: toProfile) { (conversation) in
            guard let conversation = conversation else { return }
            self.conversation = conversation
            self.fetchMessages()
        }
    }
    
    func sendMessage() {
        guard let currentUserID = FirebaseService.shared.session?.uid else { return }
        let message = Message(content: textFieldText, ownerID: currentUserID)
        MessagingService.shared.sendMessage(conversation: self.conversation, message: message)
    }
    
    func fetchMessages() {
        MessagingService.shared.fetchMessages(from: conversation) { (messages) in
            if let messages = messages {
                self.messages = messages
                self.listenForNewMessages()
            }
            
        }
    }
    func listenForNewMessages(){
        MessagingService.shared.fetchNewMessages(from: conversation) { (message) in
            if let message = message {
                if !self.messages.contains(message) {
                    self.messages.append(message)
                }
            }
        }
    }
}
