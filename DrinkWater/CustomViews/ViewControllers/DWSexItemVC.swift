//
//  DWSexItemVC.swift
//  DrinkWater
//
//  Created by David Laiymani on 21/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class DWSexItemVC: UIViewController {
    
    let sexLabel = DWTitleLabel(textAlignment: .left, fontSize: 15)
    let maleButton = DWButton(backgroundColor: DWColors.whiteColor, title: "M")
    let femaleButton = DWButton(backgroundColor: DWColors.greenColor, title: "F")
    let stackView = UIStackView()
    
    var sex = "F"
    
    var user: User!
    
    init(profile: User) {
        super.init(nibName: nil, bundle: nil)
        user = profile
        sex = user.sex
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
        
        if sex == "F" {
            femaleTapped()
        } else {
            maleTapped()
        }
        
        
        maleButton.set(textColor: DWColors.grayColor)
        femaleButton.addTarget(self, action: #selector(femaleTapped), for: .touchUpInside)
        maleButton.addTarget(self, action: #selector(maleTapped), for: .touchUpInside)
    }
    
    @objc private func femaleTapped() {
        femaleButton.backgroundColor = UIColor(cgColor: DWColors.greenColor)
        femaleButton.set(textColor: DWColors.whiteColor)
        maleButton.backgroundColor = UIColor(cgColor: DWColors.whiteColor)
        maleButton.set(textColor: DWColors.grayColor)
        sex = "F"
    }
    
    @objc private func maleTapped() {
        
        maleButton.backgroundColor = UIColor(cgColor: DWColors.greenColor)
        maleButton.set(textColor: DWColors.whiteColor)
        femaleButton.backgroundColor = UIColor(cgColor: DWColors.whiteColor)
        femaleButton.set(textColor: DWColors.grayColor)
        sex = "M"
    }
    
    private func layoutUI() {
        view.addSubview(sexLabel)
        view.addSubview(stackView)

        sexLabel.text = "⚤ Sex"
        
        let padding: CGFloat = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            sexLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            sexLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            sexLabel.heightAnchor.constraint(equalToConstant: 30),
            
          //  stackView.topAnchor.constraint(equalTo: sexLabel.bottomAnchor, constant: padding),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: view.frame.width/3),
            stackView.heightAnchor.constraint(equalToConstant: 30)
            
   
        ])
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        stackView.addArrangedSubview(femaleButton)
        stackView.addArrangedSubview(maleButton)
    }

}

