//
//  DWStatsView.swift
//  DrinkWater
//
//  Created by David Laiymani on 11/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class DWStatsView: UIView {
    
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0

    override init(frame: CGRect) {
        super.init(frame: frame)
     
        self.backgroundColor = UIColor(cgColor: DWColors.lightGreenColor)
    }
    
     
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        super.init(frame: .zero)
        
        self.width = width
        self.height = height
                
        self.frame = CGRect(x: x, y: y, width: width, height: height)
        self.layer.cornerRadius = 20
        self.backgroundColor = UIColor(cgColor: DWColors.lightGreenColor)
        
    }
    

}
