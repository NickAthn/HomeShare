//
//  HostingRowView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 14/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct HostingRow: View {
    var accommodation: Accommodation
    
    @State private(set) var image: UIImage = UIImage(named: "exampleImage")!
    
    var body: some View {
        VStack(alignment: .leading){
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .cornerRadius(10)
                .clipped()
            Text(accommodation.address)
                .font(.headline)
        }.onAppear(perform: loadRemoteImage)
    }
    
    func loadRemoteImage() {
        FirStorageManager.shared.download(imageWithURL: accommodation.imageURL) { image in
            if image != nil {
                DispatchQueue.main.async {
                    self.image = image!
                }
            }
        }
    }
    
}
