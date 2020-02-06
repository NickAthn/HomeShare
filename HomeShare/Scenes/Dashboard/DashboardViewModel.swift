//
//  DashboardViewModel.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 6/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation

class DashboardViewModel: ObservableObject {
    @Published var taskList: [Task] = []
    
    init() {
        generateTaskList()
    }
    
    func generateTaskList() {
        if let verificationStatus = FirebaseService.shared.session?.verificationStatus {
            if verificationStatus == .notVerified {
                taskList.append(Task.systemTasks.first {$0.id == "verificationNeeded"}!)
            }
        }
    }
}
