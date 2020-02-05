//
//  MessageRow.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 5/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct MessageRow: View {
    var alignment: HorizontalAlignment = .leading
    var message: Message
    var body: some View {
        VStack(alignment: alignment) {
            Text(message.content)
        }
    }
}
