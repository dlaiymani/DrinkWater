//
//  String+Ext.swift
//  DrinkWater
//
//  Created by David Laiymani on 27/04/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import Foundation

extension String {
    func convertToDate() -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }


    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        
        return date.convertToDayMonthYearFormat()
    }
}

