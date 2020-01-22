//
//  AddAccommodationViewModel.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 14/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI
import Combine

class AddAccommodationViewModel: ObservableObject {
    let didChange = PassthroughSubject<Void, Never>()

    func addImage(){
        
    }
    func saveAccommodation(address: String){
        DispatchQueue.global(qos: .userInitiated).async {
            FirDatabaseManager.shared.createAccommodation(address: address)
        }
    }
}
