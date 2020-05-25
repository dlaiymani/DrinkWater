//
//  Helper.swift
//  DrinkWater
//
//  Created by David Laiymani on 28/04/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

struct Helper {
    
    static func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0x00FF00) >> 8))/255.0, blue: ((CGFloat)((rgbValue & 0x0000FF)))/255.0, alpha: 1.0)
    }
    
}
