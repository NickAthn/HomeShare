//
//  StructWrapper.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 7/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation


/// Generic struct wrapper. To be used with NSCache and enable that functionality to structs.
class StructWrapper<T>: NSObject {
    let value: T
    init(_ _struct: T) {
        self.value = _struct
    }
}

