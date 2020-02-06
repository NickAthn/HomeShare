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
    var foregroundColor: Color {
        get {
            if senderID == message.ownerID {
                return Color.white
            } else {
                return Color.black
            }
        }
    }
    var backgroundColor: Color {
        get {
            if senderID == message.ownerID {
                return Color.blue
            } else {
                return Color.Token.fieldDefault
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
                .padding(10)
                .foregroundColor(foregroundColor)
                .background(backgroundColor)
                .cornerRadius(20)
        }
    }
}

