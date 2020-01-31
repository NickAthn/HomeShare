//
//  ProfileEditView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 29/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct ProfileEditView: View {
    @ObservedObject var viewModel: ProfileEditViewModel = ProfileEditViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: self.$viewModel.statusPickerSelection, label: Text("Status")) {
                        ForEach(0..<GuestStatus.allCases.count, id: \.self) { index in
                            Text(GuestStatus.allCases[index].getDescription()).tag(index)
                        }
                    }.id(0)
                }
                
                Section {
                    NavigationLink(destination: AboutMeEditView(viewModel: self.viewModel)) {
                        Text("About me")
                    }
                }
                                
            }
            .navigationBarTitle("Edit Profile")
            .navigationBarItems(trailing: Button("Save", action: save))
        
        }
    }
    
    func save() {
        viewModel.saveProfileChanges()
        presentationMode.wrappedValue.dismiss()
    }

}

struct AboutMeEditView: View {
    @ObservedObject var viewModel: ProfileEditViewModel
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                HStack {
                    Text("First")
                        .frame(width: 50,alignment: .leading)
                        .padding(.trailing, 10)
                    Spacer()
                    TextField("Required", text: self.$viewModel.profile.firstName)
                }
                HStack {
                    Text("Last").padding(.trailing)
                        .frame(width: 50,alignment: .leading)
                        .padding(.trailing, 10)
                    Spacer()
                    TextField("Required", text: self.$viewModel.profile.lastName)
                }
            }
            
            Section(header: Text("Description")) {
                VStack {
                    TextView(text: self.$viewModel.profile.description)
                    .frame(height: 200)
                }
            }
        }.navigationBarTitle("About Me", displayMode: .inline)
    }
}
