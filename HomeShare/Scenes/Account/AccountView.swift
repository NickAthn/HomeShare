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
                NavigationLink(destination: HostingView(), isActive: self.$viewModel.showHostingView) {EmptyView()}.hidden()
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    ZStack(alignment: .bottomLeading) {
                        StickyImage()
                            .frame(height: 300)
                        
                        
                        VStack(alignment: .leading) {
                            Text("Nikolaos Athanasiou")
                                .foregroundColor(.white)
                                .font(.system(size: 24, weight: .black, design: .default))
                            Text("Messini, Peloponnisos, Greece")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .bold, design: .default))
                        }
                        .padding(.leading)
                        .padding(.bottom)
                    }
                    
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 30)
                            .foregroundColor(.green)
                        HStack {
                            Image("verified_account")
                            Text("Verified Account")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .bold, design: .default))
                        }.padding(.leading)
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 0.2) {
                        OptionRow(title: "Hosting", style: .normal) {
                            self.viewModel.showHostingView.toggle()
                        }
                        OptionRow(title: "Notifications", style: .normal)
                        OptionRow(title: "Bookmarked", style: .normal)
                        OptionRow(title: "Log Out", style: .button) {self.viewModel.signOut()}
                        
                        OptionRow(title: "Delete Account", style: .alertButton) {
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

                        OptionRow(title: "Sumbit a ticket", style: .normal)
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

