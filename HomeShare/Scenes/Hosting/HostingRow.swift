//
//  HostingRowView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 14/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct HostingRow: View {
    var accommodation: Accommodation
    
    var body: some View {
        VStack(alignment: .leading){
            Image("exampleImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .cornerRadius(10)
                .clipped()
            Text(accommodation.address)
                .font(.headline)
        }
    }
}

//struct HostingRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        HostingRow(accommodation: Accommodation()).padding()
//    }
//}
