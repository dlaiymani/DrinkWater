//
//  Int+Ext.swift
//  DrinkWater
//
//  Created by David Laiymani on 05/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import Foundation


extension Int {
    func convertToDayLetter() -> String {
        switch self {
        case 0:
            return "M"
        case 1:
            return "T"
        case 2:
            return "W"
        case 3:
            return "T"
        case 4:
            return "F"
        case 5:
            return "S"
        case 6:
            return "S"
        default:
            return "Z"
        }
    }
}
