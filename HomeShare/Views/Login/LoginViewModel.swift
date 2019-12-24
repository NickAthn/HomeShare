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
    // MARK: - PROPERTIES
    let didChange = PassthroughSubject<Void, Never>()

    @Published var hasError: Bool = false
    @Published var errorMessage: String = ""
    
    // NAVIGATION
    @Published var showRegisterModal = false

    // MARK: - Methods
    func startListener(){
        FirebaseManager.shared.listen()
    }
    
    func login(mail: String, password: String){
        print("🐞 Login Pressed")
        FirebaseManager.shared.signIn(withEmail: mail, password: password) { result, error in
            if error != nil {
                self.hasError = true
                self.errorMessage = FirebaseManager.shared.getErrorDescription(error!)
            }
        }
    }

}

