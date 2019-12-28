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
        ScrollView {
            VStack(alignment: .leading) {
                
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
                }.offset(y: -8) // Fix for a padding which is not visible.
                
                
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
