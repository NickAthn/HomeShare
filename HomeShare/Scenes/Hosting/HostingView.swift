//
//  HostingView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 11/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI
import Combine

struct HostingView: View {
    @ObservedObject var viewModel: HostingViewModel = HostingViewModel()
    @State var showAddAccommodation = false
    
    var body: some View {
        List(viewModel.accommodations) { accommodation in
            HostingRow(accommodation: accommodation)
        }
        .sheet(isPresented: self.$showAddAccommodation, onDismiss: {self.viewModel.loadAccommodations()}) {
            AddAccommodationView()
        }
        .onAppear{
            self.viewModel.loadAccommodations()
        }
        .navigationBarTitle("Hosting")
        .navigationBarItems(trailing: Button("Add") {
            self.showAddAccommodation.toggle()
        })
    }
    
    
//    init() {
//        // To remove only extra separators below the list:
//        UITableView.appearance().tableFooterView = UIView()
//
//        // To remove all separators including the actual ones:
//        UITableView.appearance().separatorStyle = .none
//    }
}

struct HostingView_Previews: PreviewProvider {
    static var previews: some View {
        HostingView()
    }
}
