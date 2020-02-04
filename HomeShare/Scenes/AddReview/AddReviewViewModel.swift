//
//  AddReviewViewModel.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 4/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
import Combine

class AddReviewViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var desc: String = ""
    
    @Published var isLikePressed: Bool = false {
        willSet {
            if isDislikedPressed { isDislikedPressed = false }
        }
        didSet {
            updateSendButton()
        }
    }
    @Published var isDislikedPressed: Bool = false {
        willSet {
            if isLikePressed { isLikePressed = false }
        }
        didSet {
            updateSendButton()
        }
    }
    
    @Published var isSendButtonDisabled: Bool = true
        
    func updateSendButton() {
        if self.isLikePressed == false && self.isDislikedPressed == false {
            self.isSendButtonDisabled = true
        } else {
            self.isSendButtonDisabled = false
        }
    }
    
    func send() {
        
    }

}

