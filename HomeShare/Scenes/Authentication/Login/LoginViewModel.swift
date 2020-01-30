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
    private var cancellables: [AnyCancellable] = []
    
    // MARK: OUTPUT
    @Published var isLoading = false
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    @Published var isUserAuthenticated = false
    
    // MARK: NAVIGATION
    @Published var showRegisterModal = false

    
    // MARK: - METHODS
    func startListener() {
        FirebaseService.shared.startSessionListener()
        
        let authTracker = FirebaseService.shared.$session.sink { session in
            if session != nil {
                self.isUserAuthenticated = true
            } else {
                self.isUserAuthenticated = false
            }
        }
        
        cancellables += [ authTracker ]
    }
    
    
    func login(mail: String, password: String) {
        if FirebaseService.shared.session == nil {
            self.isLoading = true
            FirebaseService.shared.signIn(withEmail: mail, password: password) { result, error in
                self.isLoading = false
                if error != nil {
                    self.isErrorShown = true
                    self.errorMessage = FirebaseService.shared.getErrorDescription(error!)
                }
            }
        } 
    }
}

