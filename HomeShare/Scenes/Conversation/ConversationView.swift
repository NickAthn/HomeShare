//
//  ConversationView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 5/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct ConversationView: View {
    @ObservedObject var viewModel: ConversationViewModel
//    init(conversation: Conversation) {
//        viewModel = ConversationViewModel(conversation)
//    }
    init(to: Profile) {
        viewModel = ConversationViewModel(to: to)
    }
    
    var body: some View {
        VStack {
            AutoScrollView(scrollToEnd: true) {
                ForEach(self.viewModel.messages, id:\.self) { message in
                    MessageRow(senderID: FirebaseService.shared.session!.uid, message: message)
                }
            }

            HStack {
                TextField("Message", text: self.$viewModel.textFieldText)
                Button(action: {self.viewModel.sendMessage()}) {
                    Text("Send")
                }
            }
        }.padding([.leading,.trailing])

    }
}

