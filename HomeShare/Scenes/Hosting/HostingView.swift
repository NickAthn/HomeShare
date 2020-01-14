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
                VStack(alignment: .leading){
                    Image("exampleImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .cornerRadius(10)
                        .clipped()
                    Text("Eleftherias 64, Messini, Greece ")
                        .font(.headline)
                }
            }
                
            .navigationBarTitle("Hosting")
            .navigationBarItems(trailing: Button("Add") {
                
            })
        }
    }
    
    init() {
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }

}

struct HostingView_Previews: PreviewProvider {
    static var previews: some View {
        HostingView()
    }
}
