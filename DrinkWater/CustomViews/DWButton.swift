//
//  DWButton.swift
//  DrinkWater
//
//  Created by David Laiymani on 27/04/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class DWButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(backgroundColor: CGColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(cgColor: backgroundColor)
        self.setTitle(title, for: .normal)
        
        configure()
    }
    
    
    private func configure() {
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10

    }
    
    
    func set(backgroundColor: CGColor, title: String) {
        self.backgroundColor = UIColor(cgColor: backgroundColor)
        setTitle(title, for: .normal)
    }
    
    
    func set(textColor: CGColor) {
        self.setTitleColor(UIColor(cgColor: textColor),  for: .normal)
    }
    
    func set(cornerRadius: CGFloat) {
       // layer.cornerRadius = self.frame.width/2
        layer.cornerRadius = cornerRadius

    }
    
}
