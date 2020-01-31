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
    let didChange = ObservableObjectPublisher()
    
    // MARK: OUTPUT
    @Published var isErrorShown: Bool = false
    @Published var errorMessage: String = ""

    func register(mail: String, password: String, firstName: String, lastName: String) {
        FirebaseService.shared.createUser(withEmail: mail, password: password) { result, error in
            if error != nil {
                self.isErrorShown = true
                self.errorMessage = FirebaseService.shared.getErrorDescription(error!)
            }
            guard let userID = result?.user.uid else {return}
            let newUserProfile = Profile(uid: userID, firstName: firstName, lastName: lastName)
            FirebaseService.shared.update(profile: newUserProfile) {_ in }
//            let changeRequest = result?.user.createProfileChangeRequest()
//            changeRequest?.displayName = firstName + " " + lastName
//            changeRequest?.commitChanges { error in
//                if error != nil {
//                    self.isErrorShown = true
//                    self.errorMessage = FirebaseService.shared.getErrorDescription(error!)
//                }
//            }
        }
    }

}
