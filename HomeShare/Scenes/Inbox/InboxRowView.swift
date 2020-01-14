//
//  InboxRowView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 13/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct InboxRowView: View {
    var inboxData: InboxModel
    
    var body: some View {
        HStack {
            Image("exampleImage")
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(.infinity)
            VStack(alignment: .leading){
                Text("Title")
                    .font(.headline)
                Text("Description")
                    .font(.body)
            }
        }
    }
}

struct InboxRowView_Previews: PreviewProvider {
    static var previews: some View {
        InboxRowView(inboxData: InboxModel(title: "afej", description: "aef", avatar: "aef"))
    }
}
