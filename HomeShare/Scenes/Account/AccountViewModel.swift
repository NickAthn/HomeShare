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

    func signOut() {
        FirAuthManager.shared.signOut()
    }
    
    func initiateDeleteSequence() {
        isDeleteAlertShown = true
    }
    func deleteAccount() {
        FirAuthManager.shared.deleteAccount()
    }
}
