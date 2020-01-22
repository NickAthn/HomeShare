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

    // MARK: OUTPUT
    @Published var outputImage: UIImage = UIImage(systemName: "plus.rectangle.on.rectangle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 200, weight: .regular))!
    
    // MARK: INPUT
    @Published var inputImage: UIImage?
    
    // MARK: NAVIGATION
    @Published var showImagePicker: Bool = false
    
    func loadImage() {
        if let image = inputImage {
            outputImage = image
        }
    }
    func saveAccommodation(address: String){
        DispatchQueue.global(qos: .userInitiated).async {
            FirStorageManager.shared.upload(self.inputImage!) { url in
                if let url = url {
                    FirDatabaseManager.shared.createAccommodation(imageURL: url, address: address)
                }
            }
        }
    }
}
