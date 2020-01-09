//
//  AccountView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 28/12/19.
//  Copyright © 2019 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    ZStack(alignment: .bottomLeading) {
                        StickyImage().frame(height: 300)
                        
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
                        OptionRow(destination: EmptyView(), title: "Hosting", style: .normal)
                        OptionRow(destination: EmptyView(), title: "Notifications", style: .normal)
                        OptionRow(destination: EmptyView(), title: "Bookmarked", style: .normal)
                        OptionRow(destination: EmptyView(), title: "Log Out", style: .button)
                        OptionRow(destination: EmptyView(), title: "Delete Account", style: .alertButton)
                        
                        Text("ABOUT HOMESHARE")
                            .padding(.top, 20)
                            .padding(.leading, 10)
                            .foregroundColor(.gray)
                        Rectangle()
                            .frame(height: 0.5)
                            .foregroundColor(.gray)

                        OptionRow(destination: EmptyView(), title: "Sumbit a ticket", style: .normal)

                    }
                }
            }.navigationBarTitle("Account", displayMode: .inline)
            .background(Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)))
           
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

