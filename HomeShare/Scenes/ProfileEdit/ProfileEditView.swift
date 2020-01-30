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
                Section(header: Text("Your Info")) {
                    Text("Test")
                }
                
                Section {
                    Picker(selection: self.$viewModel.profile.guestStatus, label: Text("Status")) {
                        ForEach(0 ..< GuestStatus.allCases.count) {
                            Text(GuestStatus.allCases[$0].rawValue).tag($0)
                        }
                    }
                }
                
            }
            .navigationBarTitle("Edit Profile")
            .navigationBarItems(trailing: Button("Done", action: save))
            .onAppear(perform: viewModel.fetchProfile)
        }
    }
    
    func save() {
        presentationMode.wrappedValue.dismiss()
    }

}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView()
    }
}
