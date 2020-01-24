//
//  AddAccommodationView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 14/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct AddAccommodationView: View {
    @State private var address: String = ""
    
    @ObservedObject var viewModel: AddAccommodationViewModel = AddAccommodationViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading) {
            Text("Image of the Accommodation").font(.headline)
            Button(action: { self.viewModel.showImagePicker.toggle() }) {
                Image(uiImage: viewModel.outputImage)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .frame(height: 200)
            }
            Text("Address").font(.headline)
            TextField("Address", text: $address)
                .padding()
                .background(Color.Token.fieldDefault)
                .cornerRadius(8)
            RoundedButton(title: "Submit", action: {
                self.viewModel.saveAccommodation(address: self.address) {
                    self.presentationMode.wrappedValue.dismiss()
                }
                
            })
        }
        .padding()
        .sheet(isPresented: self.$viewModel.showImagePicker, onDismiss: viewModel.loadImage) {
            ImagePicker(image: self.$viewModel.inputImage)
        }
    }
}

struct AddAccommodationView_Previews: PreviewProvider {
    static var previews: some View {
        AddAccommodationView()
    }
}
