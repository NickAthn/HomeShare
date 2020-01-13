//
//  HostingView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 11/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct HostingView: View {
    
    var body: some View {
        NavigationView {
            List {
                Text("Test")
            }
            .navigationBarTitle("Hosting")
            .navigationBarItems(trailing: Button("Add") {
                
            })
        }
    }
}

struct HostingView_Previews: PreviewProvider {
    static var previews: some View {
        HostingView()
    }
}
