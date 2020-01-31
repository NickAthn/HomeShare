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
        NavigationView {
            VStack {
                // Search view
                SearchBar(searchText: self.$viewModel.searchText, showCancelButton: self.$viewModel.showCancelButton)

            }.navigationBarTitle("Search")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
