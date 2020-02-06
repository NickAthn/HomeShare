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
                ForEach(viewModel.taskList, id: \.id) { task in
                    TaskRow(task: task)
                }
                
            }.navigationBarTitle("Dashboard", displayMode: .automatic)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

