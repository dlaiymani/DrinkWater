//
//  DWBodyLabel.swift
//  DrinkWater
//
//  Created by David Laiymani on 27/04/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class DWBodyLabel: UILabel {
    
    override init(frame: CGRect) {
          super.init(frame: frame)
      }
      
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
      

    init(textAlignment: NSTextAlignment, textLabel: String) { // dynamic type so no font size required
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.text = textLabel
        configure()
    }
      
      
    private func configure() {
        textColor = UIColor.white
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }

}
