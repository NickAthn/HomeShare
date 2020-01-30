//
//  FirebaseModel.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 30/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation

protocol FirebaseModal: Codable {
    func toData() -> Any
    func path() -> String
    
    static func pathFor(uid: String) -> String
}
