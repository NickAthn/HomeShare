//
//  ProfileView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 26/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State var showEditModal: Bool = false {
        didSet {
            if self.showEditModal == true {
                self.activeSheet = 1
                self.showSheet = true
            }
        }
    }
    @State var showConversation: Bool = false {
        didSet {
            if self.showConversation == true {
                self.activeSheet = 0
                self.showSheet = true
            }
        }
    }
    @State var showSheet: Bool = false // Due to SwiftUI Bug this cannot be stored in the viewModel as it deallocates
    @State var activeSheet: Int = 0
    
    init() {
        viewModel = ProfileViewModel()
    }
    init(profile: Profile) {
        viewModel = ProfileViewModel(profile: profile)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Navigation Links

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Profile Image
                    ZStack(alignment: .bottomLeading) {
                        StickyImage(image: Image(uiImage: viewModel.profileImage))
                            .frame(height: 300)
                        
                        VStack(alignment: .leading) {
                            Text("\(viewModel.profile.firstName) \(viewModel.profile.lastName)" )
                                .foregroundColor(.white)
                                .font(.system(size: 24, weight: .black, design: .default))
                            Text("\(viewModel.profile.home.address.getDescription())")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .bold, design: .default))
                        }
                        .padding([.leading,.bottom])
                    }
                    
                    // Account Verify Status
                    VerifyBadgeRow(profile: viewModel.profile, isViewOnly: viewModel.isViewOnly)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        // MARK: - Section 1
                        ZStack(alignment: .leading) {
                            VStack(alignment: .leading, spacing: 15) {
                                // MARK: Reviews
                                ReviewsRow(isViewOnly: viewModel.isViewOnly, profile: viewModel.profile)
                                
                                // MARK: Guest Status
                                HStack {
                                    Image("sofaIcon")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(self.viewModel.profile.guestStatus.getColor())
                                        .frame(width: 25)
                                    Text(self.viewModel.profile.guestStatus.getDescription())
                                        .foregroundColor(self.viewModel.profile.guestStatus.getColor())
                                        .font(.system(size: 17, weight:.medium, design: .rounded))
                                }
                                .padding([.leading,.trailing], 12)
                            }
                        }
                        .padding([.bottom,.top], 12)
                        .background(Color.white)
                        
                        // MARK: - Section Overview
                        ZStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                // Headline
                                Text("Overview")
                                    .font(.headline)
                                    .padding(.leading, 7)
                                VStack(alignment: .leading ,spacing: 10) {
                                    // Content
                                    if viewModel.languageInfo != "" {
                                        HStack {
                                            Image(systemName: "message.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 20)
                                            Text(viewModel.languageInfo)
                                        }
                                    }
                                    HStack {
                                        Image(systemName: "mappin.and.ellipse")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20)
                                        Text("From Greece Athens")
                                    }
                                    if viewModel.genderAgeText != "" {
                                        HStack {
                                            Image("genderIcon")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 20)
                                            Text(viewModel.genderAgeText)
                                        }
                                    }
                                    HStack {
                                        Image(systemName: "person.crop.circle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20)
                                        Text("Member since \(viewModel.profile.memberSince?.getDateStringFromUTC() ?? "unknown")")
                                        Spacer() // Necessary to fill the screen width
                                    }
                                }
                                .padding(.leading, 12)
                            }
                        }
                        .padding([.bottom,.top], 12)
                        .background(Color.white)

                        
                        // MARK: - Section Description & More
                        ZStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                // Description
                                if viewModel.profile.description != "" {
                                    Text("Description")
                                        .font(.headline)
                                        .padding(.leading, 7)
                                    Text(viewModel.profile.description)
                                        .multilineTextAlignment(.leading)
                                        .padding([.leading,.trailing], 12)
                                        .padding(.top, 5)
                                        .font(.system(size: 17, weight: .light, design: .rounded))
                                }
                                // Options
                                VStack(alignment: .leading) {
                                    NavigationLink(destination: HouseInformationView(home: self.viewModel.profile.home)){
                                        GenericRow(title: "House Information & Rules", style: .normal)
                                    }
                                    if viewModel.isViewOnly {
                                        GenericRow(title: "Save Profile", style: .normal)
                                        GenericRow(title: "Share link to the Profile", style: .normal)
                                    }
                                }
                            }
                        }
                        .padding(.top, 12)
                        .background(Color.white)
                    
                    }
                }
            } // ScrollView ends here
            .navigationBarTitle("Profile", displayMode: .inline)
            .background(Color(red: 242/255, green: 242/255, blue: 247/255))
            .navigationBarItems(trailing: Button(action: {self.showEditModal = true}) {
                if !viewModel.isViewOnly {
                    Image(systemName: "pencil.and.ellipsis.rectangle")
                        .frame(minWidth: 25)
                        .contentShape(Rectangle())

                } // Temproray until finding a way to dynamical set the bar items from the viewModel
            })
            
            if viewModel.isViewOnly {
                Button(action: {self.showConversation = true}) {
                    HStack {
                        Spacer()
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.white)
                        Text("Send Message")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(height: 45)
                        Spacer()
                    }
                }
                .buttonStyle(BorderlessButtonStyle())
                .background(Color.Token.textHighlight)
                
            }
        }
        .sheet(isPresented: self.$showSheet) {
            if self.activeSheet == 0 {
                NavigationView {
                    ConversationView(to: self.viewModel.profile)
                }
            } else {
                ProfileEditView()

            }
        }
    } 

}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
