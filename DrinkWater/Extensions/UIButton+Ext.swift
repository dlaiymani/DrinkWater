//
//  UIButton+Ext.swift
//  DrinkWater
//
//  Created by David Laiymani on 28/04/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

extension UIButton {
    
    func animatePulseOutLayer() {
        
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.fromValue = 1.0
        pulseAnimation.toValue = 0.0
        
        let groupedAnimation = CAAnimationGroup()
        groupedAnimation.animations = [pulseAnimation]
        groupedAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        groupedAnimation.duration = 0.5
        
        layer.add(groupedAnimation, forKey: "pulseAnimation")
    }
    
    
    func animatePulseInLayer() {
        
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.fromValue = 0.0
        pulseAnimation.toValue = 1.0
        
        let groupedAnimation = CAAnimationGroup()
        groupedAnimation.animations = [pulseAnimation]
        groupedAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        groupedAnimation.duration = 1.0
        
        layer.add(groupedAnimation, forKey: "pulseAnimation")
    }
    
    /**
        Set button image for all button states
        
        - Parameter image: The image to be set to the button.
        */
       open func setImage(_ image: UIImage?) {
           for state : UIControl.State in [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved] {
               self.setImage(image, for: state)
           }
       }
    
    
    open func setTitle(_ text: String?) {
        for state : UIControl.State in [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved] {
            self.setTitle(text, for: state)
        }
    }
    
}
