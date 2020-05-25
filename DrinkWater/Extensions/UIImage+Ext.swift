//
//  UIImage+Ext.swift
//  DrinkWater
//
//  Created by David Laiymani on 14/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

extension UIImage {
    
    /**
        Change the color of the image.
        
        - Parameter color: The color to be set to the UIImage.
        
        Returns an UIImage with specified color
        */
       public func colored(_ color: UIColor?) -> UIImage? {
           if let newColor = color {
               UIGraphicsBeginImageContextWithOptions(size, false, scale)
               
               let context = UIGraphicsGetCurrentContext()!
               context.translateBy(x: 0, y: size.height)
               context.scaleBy(x: 1.0, y: -1.0)
               context.setBlendMode(.normal)
               
               let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
               context.clip(to: rect, mask: cgImage!)
               
               newColor.setFill()
               context.fill(rect)
               
               let newImage = UIGraphicsGetImageFromCurrentImageContext()!
               UIGraphicsEndImageContext()
               newImage.accessibilityIdentifier = accessibilityIdentifier
               return newImage
           }
           return self
       }
}
