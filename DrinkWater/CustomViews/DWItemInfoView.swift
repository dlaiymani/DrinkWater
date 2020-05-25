//
//  DWItemInfoView.swift
//  DrinkWater
//
//  Created by David Laiymani on 20/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

enum ItemInfoType {
    case age, height, weight, sex
}


class DWItemInfoView: UIView {

   // let symbolImageView = UIImageView()
    let symbolLabel = DWTitleLabel(textAlignment: .left, fontSize: 14)
    let titleLabel = DWBoldLabel(textAlignment: .left, fontSize: 14)
    let countLabel = DWTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubview(symbolLabel)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            symbolLabel.topAnchor.constraint(equalTo: self.topAnchor),
            symbolLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolLabel.widthAnchor.constraint(equalToConstant: 20),
            symbolLabel.heightAnchor.constraint(equalToConstant: 18),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolLabel.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor, constant: 6),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 12),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
     func set(itemInfoType: ItemInfoType, withCount count: String) {
            switch itemInfoType {
            case .age:
                symbolLabel.text = "🎂"
                titleLabel.text = "Age"
            case .height:
                symbolLabel.text = "👫"
                titleLabel.text = "Height"
            case .weight:
                symbolLabel.text = "⏲"
                titleLabel.text = "Weight"
            case .sex:
                symbolLabel.text = "⚤"
                titleLabel.text = "Sex"
            }
            countLabel.text = String(count)

        }
}
