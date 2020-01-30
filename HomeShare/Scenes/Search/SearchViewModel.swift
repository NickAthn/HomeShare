//
//  SearchViewModel.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 30/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var showCancelButton: Bool = false
    
    
    
}