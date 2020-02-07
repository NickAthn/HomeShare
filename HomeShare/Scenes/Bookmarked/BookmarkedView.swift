//
//  BookmarkedView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 7/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct BookmarkedView: View {
    @ObservedObject var viewModel: BookmarkedViewModel
    init(profile: Profile) {
        viewModel = BookmarkedViewModel(profile)
    }
    
    var body: some View {
        ScrollView {
            ForEach(self.viewModel.displayedProfiles, id: \.uid) { profile in
                SearchViewRow(withProfile: profile)
            }
        }
        .navigationBarTitle("Bookmarked")
        .padding()
    }
}
