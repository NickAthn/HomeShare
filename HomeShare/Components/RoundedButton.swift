//
//  Button.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 21/12/19.
//  Copyright © 2019 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct RoundedButton: View {
    let title: String
    var action: (() -> Void)
    
    var body: some View {
        Button(action: { self.action() }){
            Spacer()
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .default))
            Spacer()
        }
        .buttonStyle(BorderlessButtonStyle())
        .padding(10)
        .background(Color.Token.buttonHighlight)
        .cornerRadius(8)
        .foregroundColor(.white)
    }
}
