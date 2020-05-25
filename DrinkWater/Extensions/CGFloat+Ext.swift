//
//  CGFloat+Ext.swift
//  DrinkWater
//
//  Created by David Laiymani on 01/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}
