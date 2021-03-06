//
//  AccountView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 28/12/19.
//  Copyright © 2019 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct AccountView: View {
    
    @ObservedObject var viewModel: AccountViewModel = AccountViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ScrollView {
                // MARK: - Navigation Links
                NavigationLink(destination: ProfileView(), isActive: self.$viewModel.showProfileView) {EmptyView()}.hidden()

                VStack(alignment: .leading, spacing: 0) {
                    
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
                        .padding(.leading)
                        .padding(.bottom)
                    }
                    
                    VerifyBadgeRow(profile: viewModel.profile, isViewOnly: false)
                    
                    VStack(alignment: .leading, spacing: 0.2) {
                        NavigationLink(destination: ProfileView() ) {
                            GenericRow(title: "Profile", style: .normal)
                        }
                        GenericRow(title: "Notifications", style: .normal)
                        NavigationLink(destination: BookmarkedView(profile: self.viewModel.profile)) {
                            GenericRow(title: "Bookmarked", style: .normal)
                        }
                        GenericRow(title: "Log Out", style: .button).onTapGesture {self.viewModel.signOut()}
                        
                        GenericRow(title: "Delete Account", style: .alertButton).onTapGesture {
                            self.viewModel.isDeleteAlertShown.toggle()
                        }.alert(isPresented: $viewModel.isDeleteAlertShown ) {
                            Alert(title: Text("DANGER ZONE"),
                                  message: Text("You are about to delete your account. This action cannot be reversed. Are you sure you want to continue?"),
                                  primaryButton: .destructive(Text("Delete")) {
                                    self.viewModel.deleteAccount()
                                },
                                  secondaryButton: .cancel()
                            )
                        }
                        
                        Text("ABOUT HOMESHARE")
                            .padding(.top, 20)
                            .padding(.leading, 10)
                            .foregroundColor(.gray)
                        Rectangle()
                            .frame(height: 0.5)
                            .foregroundColor(.gray)
                        NavigationLink(destination: SubmitTicketView()) {
                            GenericRow(title: "Sumbit a ticket", style: .normal)
                        }
                    }
                }.background(Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)))
                
            }.navigationBarTitle("Account")
        }
        .edgesIgnoringSafeArea(.top)
        .padding(.top, 1)
    }
    
    init() {
        // Trying to mimic old navbar behavior. >=12
        UINavigationBar.appearance().backgroundColor = .white
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

