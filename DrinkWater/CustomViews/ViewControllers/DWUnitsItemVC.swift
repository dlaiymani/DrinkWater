//
//  DWSexItemVC.swift
//  DrinkWater
//
//  Created by David Laiymani on 21/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class DWUnitsItemVC: UIViewController {
    
    let unitsLabel = DWTitleLabel(textAlignment: .left, fontSize: 15)
    let clButton = DWButton(backgroundColor: DWColors.greenColor, title: "cl")
    let ozButton = DWButton(backgroundColor: DWColors.whiteColor, title: "oz")
    let stackView = UIStackView()
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureSexButtons()
        configureStackView()
        layoutUI()
    }
    
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = UIColor(cgColor: DWColors.lightBlackColor)
    }
    
    private func configureSexButtons() {
        ozButton.set(textColor: DWColors.grayColor)
        
    }
    
    
    private func layoutUI() {
        view.addSubview(unitsLabel)
        view.addSubview(stackView)

        unitsLabel.text = "📏 Units"
        
        let padding: CGFloat = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            unitsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            unitsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            unitsLabel.heightAnchor.constraint(equalToConstant: 30),
            
            stackView.topAnchor.constraint(equalTo: unitsLabel.bottomAnchor, constant: padding),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: view.frame.width/3),
            stackView.heightAnchor.constraint(equalToConstant: 30)
            
   
        ])
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        stackView.addArrangedSubview(clButton)
        stackView.addArrangedSubview(ozButton)
    }

}


