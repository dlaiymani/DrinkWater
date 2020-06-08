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
    
    var unit: DWUnits = .cl
    
    var user: User!
    
    
    init(profile: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = profile
        self.unit = profile.units
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
        
        if unit == .oz {
            ozTapped()
        } else {
            clTapped()
        }
        
     //   ozButton.set(textColor: DWColors.grayColor)
        ozButton.addTarget(self, action: #selector(ozTapped), for: .touchUpInside)
        clButton.addTarget(self, action: #selector(clTapped), for: .touchUpInside)
    }
    
    
    @objc private func ozTapped() {
        ozButton.backgroundColor = UIColor(cgColor: DWColors.greenColor)
        ozButton.set(textColor: DWColors.whiteColor)
        clButton.backgroundColor = UIColor(cgColor: DWColors.whiteColor)
        clButton.set(textColor: DWColors.grayColor)
        unit = .oz
    }
    
    @objc private func clTapped() {
        
        clButton.backgroundColor = UIColor(cgColor: DWColors.greenColor)
        clButton.set(textColor: DWColors.whiteColor)
        ozButton.backgroundColor = UIColor(cgColor: DWColors.whiteColor)
        ozButton.set(textColor: DWColors.grayColor)
        unit = .cl
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


