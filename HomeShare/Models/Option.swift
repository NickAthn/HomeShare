//
//  Option.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 31/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation
enum OptionType {
    case
    toggle,
    field,
    picker
}

struct Option {
    var title: String
    var type: OptionType
}
