//
//  InboxView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 13/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct InboxView: View {
    @ObservedObject var viewModel: InboxViewModel = InboxViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.conversations) { conversation in
                    InboxRowView(conversation: conversation)
                }
            }
            .navigationBarTitle("Inbox")
            .onDisappear(perform: self.viewModel.stopFetchingConversations)
        }
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView()
    }
}
