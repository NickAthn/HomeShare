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
    // SWIFT BUG: Everytime a sheet is pressented a new viewModel gets initialised without the old one being deallocated. No workaround is sufficient, waiting for update. Temporary solution is to re-run the neccesary functions from the viewModel onComplete.
    @ObservedObject private var viewModel: HostingViewModel = HostingViewModel()
    @State var showAddAccommodation = false
    
    var body: some View {
        List(viewModel.accommodations) { accommodation in
            HostingRow(accommodation: accommodation)
        }
        .sheet(isPresented: self.$showAddAccommodation, onDismiss: self.viewModel.loadAccommodations) {
            AddAccommodationView()
        }
        .onAppear(perform: self.viewModel.loadAccommodations)
        .onDisappear(perform: self.viewModel.stopLoadingAccommodations)
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
