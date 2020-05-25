//
//  Date+Ext.swift
//  DrinkWater
//
//  Created by David Laiymani on 27/04/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import Foundation

extension Date {
    func convertToDayMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MMM dd."
        return dateFormatter.string(from: self)
    }
    
    func getWeekDay() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEEEE"
        switch dateFormatter.string(from: self) {
        case "Mo":
            return 0
        case "Tu":
            return 1
        case "We":
            return 2
        case "Th":
            return 3
        case "Fr":
            return 4
        case "Sa":
            return 5
        case "Su":
            return 6
        default:
            return -1
        }
    }
    
    
}
