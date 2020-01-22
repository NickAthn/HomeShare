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

    var body: some View {
        VStack(alignment: .leading) {
            Text("Image of the Accommodation").font(.headline)
            Button(action: { self.viewModel.addImage() }) {
                Spacer()
                Image(systemName: "plus.rectangle.on.rectangle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 100)
                    .padding()
                Spacer()
            }
            Text("Address").font(.headline)
            TextField("Address", text: $address)
                .padding()
                .background(Color.Token.fieldDefault)
                .cornerRadius(8)
            RoundedButton(title: "Submit", action: {self.viewModel.saveAccommodation(address: self.address)})
        }.padding()
    }
}

struct AddAccommodationView_Previews: PreviewProvider {
    static var previews: some View {
        AddAccommodationView()
    }
}
