//
//  AddressSearchView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 31/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct AddressSearchView: View {
    @ObservedObject var viewModel: AddressSearchViewModel = AddressSearchViewModel()

    var body: some View {
        VStack {
            SearchBar(searchText: self.$viewModel.searchText, showCancelButton: self.$viewModel.showCancelButton)
            ZStack {
                MapView()
                if self.viewModel.showCancelButton == true {
                    List {
                        // Filtered list of names
                        ForEach(viewModel.autoSuggestions, id:\.self) { suggestion in
                            Text(suggestion).onTapGesture {
                                print(suggestion)
                            }
                        
                        }
                    }
                    .resignKeyboardOnDragGesture()
                    
                }
            }
        }
    }
    
}

struct AddressSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AddressSearchView()
    }
}
