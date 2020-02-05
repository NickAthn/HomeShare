//
//  MessageRow.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 5/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct MessageRow: View {
    var senderID: String
    var alignment: HorizontalAlignment {
        get {
            if senderID == message.ownerID {
                return .trailing
            } else {
                return .leading
            }
        }
    }
    var message: Message
    var body: some View {
        VStack(alignment: alignment) {
            HStack{
                Spacer()
            }
            Text(message.content)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(20)
        }
    }
}

