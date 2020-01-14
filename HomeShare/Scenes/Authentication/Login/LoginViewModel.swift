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
    @Published var isUserAuthenticated = false
    
    // MARK: NAVIGATION
    @Published var showRegisterModal = false

    private var cancellables: [AnyCancellable] = []

    
    // MARK: - METHODS
    func startListener() {
        FirAuthManager.shared.listen()

        let trackingSubjectStream = FirAuthManager.shared.didChange.sink { firebase in
            if firebase.session != nil {
                self.isUserAuthenticated = true
            } else {
                self.isUserAuthenticated = false
            }
        }
        
        cancellables += [
            trackingSubjectStream
        ]

    }
    
    
    func login(mail: String, password: String) {
        if FirAuthManager.shared.session == nil {
            self.isLoading = true
            FirAuthManager.shared.signIn(withEmail: mail, password: password) { result, error in
                self.isLoading = false
                if error != nil {
                    self.isErrorShown = true
                    self.errorMessage = FirAuthManager.shared.getErrorDescription(error!)
                }
            }
        } else {
//            self.isUserAuthenticated = true
        }
    }
}
