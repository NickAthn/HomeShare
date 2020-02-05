//
//  InboxViewModel.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 13/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI
import Combine

class InboxViewModel: ObservableObject {
    let didChange = PassthroughSubject<Void, Never>()
    
    @Published var conversations: [Conversation] = []
    
    init() {
        self.fetchConversations()
    }
    
    func fetchConversations() {
        FirebaseService.shared.fetchProfileForCurrentUser { (profile) in
            if let profile = profile {
                MessagingService.shared.fetchConverastions(for: profile) { (conversations) in
                    self.conversations = conversations
                }
            }
        }
    }
}

