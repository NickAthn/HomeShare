//
//  AddressSearchViewModel.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 31/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI
import Combine

class AddressSearchViewModel: ObservableObject {
//    let didSet = PassthroughSubject<AddressSearchViewModel, Never>()
    var locationService = LocationService()
    private var cancellables: [AnyCancellable] = []

    @Published var searchText: String = ""
    
    @Published var showCancelButton = false
    @Published var autoSuggestions: [String] = []
    
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
