//
//  Int+Extensions.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 6/2/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import Foundation

extension Double {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "MMM, yyyy"

        return dateFormatter.string(from: date)
    }
    func getYearsSinceFromUTC() -> Int{
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let age = Calendar.current.dateComponents([.year], from: date, to: Date()).year!
        return age
    }
    func toDate() -> Date {
        return Date(timeIntervalSince1970: self)
    }
}
