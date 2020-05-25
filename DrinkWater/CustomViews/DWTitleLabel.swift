//
//  DWTitleLabel.swift
//  DrinkWater
//
//  Created by David Laiymani on 27/04/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class DWTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
       
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       

    init(textAlignment: NSTextAlignment, fontSize: CGFloat) { // Not use of dynamic type, so font size required
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .light)
        configure()
    }
       
       
    private func configure() {
        textColor = .white
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}
