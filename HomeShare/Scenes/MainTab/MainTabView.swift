//
//  MainTabView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 26/12/19.
//  Copyright © 2019 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Image(systemName: "circle.bottomthird.split")
                    Text("Dashboard")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
            }
            InboxView()
                .tabItem {
                    Image(systemName: "tray")
                    Text("Inbox")
                }
            AccountView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Account")
                }
        }.edgesIgnoringSafeArea(.top)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
