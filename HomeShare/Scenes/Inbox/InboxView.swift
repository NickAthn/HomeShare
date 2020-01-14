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
            .navigationBarTitle("Inbox")
        }
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView()
    }
}
