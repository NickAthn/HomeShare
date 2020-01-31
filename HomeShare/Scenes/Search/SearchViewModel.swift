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
        }
    }
    @Published var showCancelButton: Bool = false
    @Published var displayedProfiles: [Profile] = [Profile(uid: "afafa", firstName: "nicik", lastName: "Hansome")]
    
    @Published var autoSuggestions: [String] = []
    @Published var showSuggestions: Bool = false
    @Published var isSearchCommited: Bool = false {
        didSet {
            if self.isSearchCommited == true {
                showSuggestions = false
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

}
