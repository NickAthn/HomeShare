//
//  SearchViewModel.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 30/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    var locationService = LocationService()
    private var cancellables: [AnyCancellable] = []

    @Published var searchText: String = "" {
        didSet {
            showSuggestions = true
            isSearchCommited = false
            displayedProfiles = []
        }
    }
    @Published var showCancelButton: Bool = false {
        didSet {
            if self.showCancelButton == false {
                showSuggestions = false
            }
        }
    }
    @Published var displayedProfiles: [Profile] = []
    
    @Published var autoSuggestions: [String] = []
    @Published var showSuggestions: Bool = false
    @Published var isSearchCommited: Bool = false {
        didSet {
            if self.isSearchCommited == true {
                showSuggestions = false
                getProfiles()
            }
        }
    }
    
    init() {
        bind()
    }
    func bind(){
        locationService.bind(text: self.$searchText)
        let stream = locationService.$suggestions.sink { suggestions in
            self.autoSuggestions = suggestions
        }
        cancellables += [ stream ]
    }
    
    func getProfiles() {
        FirebaseService.shared.getProfiles(for: searchText) { profiles in
            self.displayedProfiles = profiles
        }
    }

}
