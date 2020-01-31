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
                    NavigationLink(destination: AboutMeEditView(viewModel: self.viewModel)) {
                        Text("About me")
                    }
                    NavigationLink(destination: AboutMeEditView(viewModel: self.viewModel)) {
                        Text("About me")
                    }

                }
                TextField("First Name", text: self.$viewModel.profile.firstName)

                                
            }
            .navigationBarTitle("Edit Profile")
            .navigationBarItems(trailing: Button("Done", action: save))
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
            TextField("First Name", text: self.$viewModel.profile.firstName)
            TextField("Last Name", text: self.$viewModel.profile.firstName)
        }
    }
}
