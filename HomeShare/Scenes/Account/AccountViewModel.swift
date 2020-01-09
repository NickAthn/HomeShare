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

    
    func signOut() {
        FirebaseManager.shared.signOut()
    }
}
