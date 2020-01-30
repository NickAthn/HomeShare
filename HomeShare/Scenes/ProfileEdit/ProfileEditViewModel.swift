//
//  ProfileEditViewModel.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 30/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import Combine

class ProfileEditViewModel: ObservableObject {

    // MARK: - OUTPUT
    @Published var selectedGuestStatus: GuestStatus = .notAccepting
    
}