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
    @State private var offsetValue: CGFloat = 0.0

    init(to: Profile) {
        viewModel = ConversationViewModel(to: to)
    }
    
    var body: some View {

        VStack {
            AutoScrollView(extraOffset: $offsetValue, scrollToEnd: true) {
                ForEach(self.viewModel.messages, id:\.self) { message in
                    MessageRow(senderID: FirebaseService.shared.session!.uid, message: message)
                }
            }.padding(.bottom)
            
            HStack {
                TextField("Message", text: self.$viewModel.textFieldText)
                Button(action: {self.viewModel.sendMessage()}) {
                    Text("Send")
                }
            }
        }
        .padding([.leading,.trailing,.bottom])
        .keyboardSensible($offsetValue)
    }
}

