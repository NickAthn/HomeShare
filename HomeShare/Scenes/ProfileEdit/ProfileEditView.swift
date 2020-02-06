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
            VStack {
                Button(action: {self.viewModel.showImagePicker.toggle()}) {
                    ZStack(alignment: .bottom) {
                        Image(uiImage: self.viewModel.profileImage ?? UIImage(named: "genericProfileImage")!)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .clipped()
                            .cornerRadius(.infinity)
//                            .mask(Rectangle().padding(.bottom, 10).foregroundColor(.black))
                        }
                }
                .padding(.top, 25)
                
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
                        NavigationLink(destination: AddressSearchView(selectedAddress: self.$viewModel.profile.home.address, isActive: self.$viewModel.isActive), isActive: self.$viewModel.isActive){
                            HStack {
                                Text("Address")
                                Spacer()
                                Text(self.viewModel.profile.home.address.getDescription()).font(.body).foregroundColor(.secondary)
                            }
                        }
                    }
                                    
                }
                .navigationBarTitle("Edit Profile")
                .navigationBarItems(trailing: Button("Save", action: save))
            }.sheet(isPresented: self.$viewModel.showImagePicker) {
                ImagePicker(image: self.$viewModel.profileImage)
            }
            .background(Color(red: 242/255, green: 242/255, blue: 247/255))
        }
    }
    
    func save() {
        viewModel.saveProfileChanges()
        presentationMode.wrappedValue.dismiss()
    }

}

struct AboutMeEditView: View {
    @ObservedObject var viewModel: ProfileEditViewModel
    @State private var offsetValue: CGFloat = 0.0

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
            
            Section {
                VStack {
                    DatePicker(selection: self.$viewModel.birthDate, in: ...Date(), displayedComponents: .date) {
                        Text("Birthday")
                    }
                }
            }

            Section(header: Text("Languages")) {
                HStack {
                    TextField("Fluent in English, Basic Italian etc...", text: self.$viewModel.languageInfo)
                }
            }
            
            Section(header: Text("Gender")) {
                VStack {
                    Picker(selection: self.$viewModel.genderPickerSelection, label: Text("Gender")) {
                        ForEach(0..<Gender.allCases.count, id: \.self) { index in
                            Text(Gender.allCases[index].description).tag(index)
                        }
                    }
                    .id(1)
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            

            
        }
        .navigationBarTitle("About Me", displayMode: .inline)
        .keyboardSensible($offsetValue)
    }
}
