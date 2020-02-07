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
                SearchBar(searchText: self.$viewModel.searchText, showCancelButton: self.$viewModel.showCancelButton) {
                    self.viewModel.isSearchCommited = true
                }
                if viewModel.showSuggestions {
                    List {
                        // Filtered list of names
                        ForEach(viewModel.autoSuggestions, id:\.self) { suggestion in
                            Text(suggestion).onTapGesture {
                                self.viewModel.searchText = suggestion
                            }
                        }
                    }
                    .resignKeyboardOnDragGesture()
                } else if viewModel.isSearchCommited {
                    List {
                        // Filtered list of names
                        ForEach(viewModel.displayedProfiles, id:\.self) { profile in
                            SearchViewRow(withProfile: profile)
                        }.padding(.trailing, -20) // TODO: Delete after finding another way to remove the disclosure inidcator
                    }

                } else {
                    // Just in case of empty view to put the search bar on top
                    Spacer()
                }
            }.navigationBarTitle("Search")
        }
    }
}
