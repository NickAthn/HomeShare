//
//  Address.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 31/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation

struct Address: Codable {
    var city: String = ""
    var region: String = ""
    var country: String = ""
    var postalCode: String = ""
    
    func getDescription() -> String {
        var description: String = ""
        if city != "" {
            description += "\(city), "
        }
        if region != "" {
            description += "\(region), "
        }
        if country != "" {
            description += "\(country), "
        }
        return description
    }
}
