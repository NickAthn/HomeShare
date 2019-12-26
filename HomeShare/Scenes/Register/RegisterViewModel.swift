//
//  RegisterViewModel.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 22/12/19.
//  Copyright © 2019 Nikolaos Athanasiou. All rights reserved.
//
import SwiftUI
import Combine
import Firebase


class RegisterViewModel: ObservableObject{
    let didChange = PassthroughSubject<Void, Never>()
    
    // MARK: OUTPUT
    @Published var hasError: Bool = false
    @Published var errorMessage: String = ""

    func register(mail: String, password: String, firstName: String, lastName: String){
        FirebaseManager.shared.registerUser(withEmail: mail, password: password) { result, error in
            if error != nil {
                self.hasError = true
                self.errorMessage = FirebaseManager.shared.getErrorDescription(error!)
            }
            let changeRequest = result?.user.createProfileChangeRequest()
            changeRequest?.displayName = firstName + " " + lastName
            changeRequest?.commitChanges { error in
                if error != nil {
                    self.hasError = true
                    self.errorMessage = FirebaseManager.shared.getErrorDescription(error!)
                }
            }
        }
    }

}
