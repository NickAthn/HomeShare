//
//  DashboardView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 9/12/19.
//  Copyright © 2019 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI
enum SystemTaskID: String, CaseIterable {
    case
    verificationNeeded
}
struct Task: Identifiable {
    let id: String
    
    let image: Image
    let color: Color
    let title: String
    let desc: String
    
    let isDone: Bool = false
        
    static let systemTasks = [
        Task(id: "verificationNeeded", image: Image(systemName: "checkmark.seal.fill"), color: Color(.systemGreen), title: "Your account is not verified", desc: "You have to confirm your email to verify your account."),
    ]
}

struct DashboardView: View {
    @ObservedObject var viewModel = DashboardViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    if !viewModel.taskList.isEmpty {
                        Text("To - Do").font(.headline)
                        ForEach(viewModel.taskList, id: \.id) { task in
                            TaskRow(task: task)
                        }.padding(.bottom)
                    }
                    HStack(alignment: .top) {
                        Text("People around you?")
                            .font(.headline)
                            .padding(.bottom)
                        Spacer()
                        if viewModel.isLocationLoading {
                            ActivityIndicator(isAnimating: self.$viewModel.isLocationLoading, style: .medium)
                                .padding(0)
                        }
                    }
                    if viewModel.lastUserLocation != nil {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(self.viewModel.profilesNear , id: \.uid) { profile in
                                    SearchViewRow(withProfile: profile)
                                    .frame(width: 330)
                                    .fixedSize()
                                }
                            }.padding(.horizontal, 18)
                        }.padding(.horizontal, -18)
                    } else {
                        RoundedButton(title: "Use my current location") {
                            self.viewModel.requestLocationAccess()
                        }
                        .padding([.leading,.trailing])
                        .disabled(viewModel.isLocationLoading)
                        
                    }
                }.padding()
            }
            .navigationBarTitle("Dashboard", displayMode: .automatic)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

