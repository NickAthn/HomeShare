//
//  SearchViewRow.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 30/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI
//
struct SearchViewRow: View {
    var withProfile: Profile

    var body: some View {
        NavigationLink (destination: EmptyView()) {
            VStack {
                ZStack(alignment: .bottomLeading) {
                    Image("exampleImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .cornerRadius(10)
                        .clipped()
                    VStack(alignment: .leading) {
                        Text("\(withProfile.firstName) \(withProfile.lastName)" )
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .black, design: .default))
                        Text("\(withProfile.home.address.getDescription())")
                            .foregroundColor(.white)
                            .font(.system(size: 17, weight: .bold, design: .default))
                    }
                    .padding(.leading)
                    .padding(.bottom)
                }
            }.padding(.trailing, -15)
        }
    }
}
