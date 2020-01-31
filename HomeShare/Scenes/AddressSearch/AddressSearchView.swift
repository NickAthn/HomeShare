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
    @Binding var selectedAddress: Address // TODO: Make initiliser and move this value to the viewModel
    @Binding var isActive: Bool
    
    var body: some View {
        VStack {
            SearchBar(searchText: self.$viewModel.searchText, showCancelButton: self.$viewModel.showCancelButton)
                .padding(.top, 10)
            ZStack {
                MapView()
                if self.viewModel.showCancelButton == true {
                    List {
                        // Filtered list of names
                        ForEach(viewModel.autoSuggestions, id:\.self) { suggestion in
                            Text(suggestion).onTapGesture {
                                self.save(addressString: suggestion)
                            }
                        
                        }
                    }
                    .resignKeyboardOnDragGesture()
                }
            }
        }
        .navigationBarTitle("Find your Address", displayMode: .inline)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    func save(addressString: String) {
        viewModel.getFormatFor(addressString) { address in
            self.selectedAddress = address
            self.isActive = false // On completion dismish
        }
    }
    
}

