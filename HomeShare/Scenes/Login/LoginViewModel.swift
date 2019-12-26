//
//  LoginViewModel.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 22/12/19.
//  Copyright © 2019 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI
import Combine
import Firebase

class LoginViewModel: ObservableObject {
    let didChange = PassthroughSubject<Void, Never>()

    // MARK: OUTPUT
    @Published var isLoading = false
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    @Published var isUserAuthenticated = false {
        didSet { showMainTab = self.isUserAuthenticated }
    }
    
    
    // MARK: NAVIGATION
    @Published var showRegisterModal = false
    @Published var showMainTab = false

    private var cancellables: [AnyCancellable] = []

    
    // MARK: - METHODS
    func startListener() {
        FirebaseManager.shared.listen()
        FirebaseManager.shared.signOut()
        let trackingSubjectStream = FirebaseManager.shared.didChange.sink { firebase in
            if firebase.session != nil {
                self.isUserAuthenticated = true
            }
        }
        
        cancellables += [
            trackingSubjectStream
        ]

    }
    
    
    func login(mail: String, password: String) {
        if FirebaseManager.shared.session == nil {
            self.isLoading = true
            FirebaseManager.shared.signIn(withEmail: mail, password: password) { result, error in
                self.isLoading = false
                if error != nil {
                    self.isErrorShown = true
                    self.errorMessage = FirebaseManager.shared.getErrorDescription(error!)
                }
            }
        } else {
            self.isUserAuthenticated = true
        }
    }
}

