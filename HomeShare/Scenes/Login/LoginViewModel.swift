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

class LoginViewModel: ObservableObject{
    let didChange = PassthroughSubject<Void, Never>()

    // MARK: Output
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    @Published var isUserAuthenticated = false {
        didSet { showDashboard = self.isUserAuthenticated }
    }
    
    // MARK: NAVIGATION
    @Published var showRegisterModal = false
    @Published var showDashboard = false


    // MARK: - Methods
    func startListener(){
        FirebaseManager.shared.listen()
    }
    
    func login(mail: String, password: String){
        FirebaseManager.shared.signIn(withEmail: mail, password: password) { result, error in
            if error != nil {
                self.isErrorShown = true
                self.errorMessage = FirebaseManager.shared.getErrorDescription(error!)
            }
        
            self.isUserAuthenticated = true
            print(self.showDashboard)
        }
    }

}

