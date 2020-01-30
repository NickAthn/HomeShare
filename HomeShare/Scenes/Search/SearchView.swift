//
//  SearchView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 30/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            // Search view
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")

                    TextField("search", text: self.$viewModel.searchText, onEditingChanged: { isEditing in
                        self.viewModel.showCancelButton = true
                    }, onCommit: {
                        print("onCommit")
                    }).foregroundColor(.primary)

                    Button(action: {
                        self.viewModel.searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill").opacity(self.viewModel.searchText == "" ? 0.0 : 1.0)
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .foregroundColor(.secondary)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10.0)

                if self.viewModel.showCancelButton  {
                    Button("Cancel") {
                            UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                            self.viewModel.searchText = ""
                            self.viewModel.showCancelButton = false
                    }
                    .foregroundColor(Color(.systemBlue))
                }
            }
            .padding(.horizontal)
            .navigationBarHidden(self.viewModel.showCancelButton) // .animation(.default) // animation does not work properly
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
