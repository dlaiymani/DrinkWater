//
//  UIView+Ext.swift
//  DrinkWater
//
//  Created by David Laiymani on 14/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

extension UIView {
    /**
     Set the corner radius of the view.
     
     - Parameter color:        The color of the border.
     - Parameter cornerRadius: The radius of the rounded corner.
     - Parameter borderWidth:  The width of the border.
     */

    open func setCornerBorder(color: UIColor? = nil, cornerRadius: CGFloat = 15.0, borderWidth: CGFloat = 1.5) {
        self.layer.borderColor = color != nil ? color!.cgColor : UIColor.clear.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }

}
