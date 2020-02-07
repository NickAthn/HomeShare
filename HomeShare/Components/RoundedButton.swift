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
                .frame(height: 45)

            Spacer()
        }
        .buttonStyle(BorderlessButtonStyle())
        .background(Color.Token.buttonHighlight)
        .cornerRadius(8)
        .foregroundColor(.white)
        

    }
}

#if DEBUG
struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(title: "Test") {
            print("")
        }.padding()
    }
}
#endif
