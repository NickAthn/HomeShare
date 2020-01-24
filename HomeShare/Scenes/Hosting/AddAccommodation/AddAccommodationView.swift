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
    @State private var title: String = ""
    @State private var description: String = ""
    
    @State private var numberOfOccupants: Int = 1

    @ObservedObject var viewModel: AddAccommodationViewModel = AddAccommodationViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .center) {
            Text("Create a new accommodation")
                .font(.headline)
                .padding()
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Title")
                    TextField("Title", text: $title)
                        .modifier(MainTextField())
                    
                    Text("Image of the Accommodation")
                    Button(action: { self.viewModel.showImagePicker.toggle() }) {
                        Image(uiImage: viewModel.outputImage)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height: 200)
                    }
                    
                    Text("Address")
                    TextField("Address", text: $address)
                        .modifier(MainTextField())
                    
                    
                    Text("Description")
                    TextView(text: $description)
                        .modifier(MainTextField())
                        .frame(height: 250)
                    
                    Stepper("Max Number of Guests: \(numberOfOccupants)", value: $numberOfOccupants, in: 1...100)
                    
                    RoundedButton(title: "Save", action: {
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
    }
}

struct AddAccommodationView_Previews: PreviewProvider {
    static var previews: some View {
        AddAccommodationView()
    }
}
