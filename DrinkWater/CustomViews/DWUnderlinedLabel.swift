//
//  DWUnderlinedLabel.swift
//  DrinkWater
//
//  Created by David Laiymani on 03/06/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class DWUnderlinedLabel: UILabel {
    
    var textLabel: NSMutableAttributedString!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
       
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       

    init(textAlignment: NSTextAlignment, fontSize: CGFloat, text: String) { // Not use of dynamic type, so font size required
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
        self.textLabel = NSMutableAttributedString.init(string: text)
        configure()
    }
       
       
    private func configure() {
        textColor = .white
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
        
        let pos = 9
        let range = NSMakeRange(pos, textLabel.length-pos)
        
        textLabel.addAttribute(NSAttributedString.Key.underlineStyle, value: 2, range: range )
        textLabel.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor(cgColor: DWColors.greenColor), range: range)

        self.attributedText = textLabel
        
    }

}
