//
//  AccountViewModel.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 9/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI
import Combine

class AccountViewModel: ObservableObject {
    let didChange = PassthroughSubject<Void, Never>()

    // MARK: OUTPUT
    @Published var isDeleteAlertShown = false

    // MARK: NAVIGATION
    @Published var showHostingView = false
    @Published var showProfileView = false


    func signOut() {
        FirebaseService.shared.signOut()
    }
    
    func initiateDeleteSequence() {
        isDeleteAlertShown = true
    }
    func deleteAccount() {
        FirebaseService.shared.deleteAccount()
    }
}
