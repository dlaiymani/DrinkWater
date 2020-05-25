//
//  DWGoalItemVC.swift
//  DrinkWater
//
//  Created by David Laiymani on 22/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class DWGoalItemVC: UIViewController {
    
    let goalTitleLabel = DWTitleLabel(textAlignment: .left, fontSize: 15)
    let goalLabel = DWTitleLabel(textAlignment: .left, fontSize: 18)
    let plusButton = DWButton(backgroundColor: DWColors.greenColor, title: "+")
    let minusButton = DWButton(backgroundColor: DWColors.greenColor, title: "-")
    
    let stackView = UIStackView()
    
    let goal = 200
    private let buttonsSize: CGFloat = 25
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureButtons()
        configureGoalLabel()
        layoutUI()
        configureStackView()

    }
    
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = UIColor(cgColor: DWColors.lightBlackColor)
    }
    
    
    private func configureButtons() {
        plusButton.set(textColor: DWColors.blackColor)
        minusButton.set(textColor: DWColors.blackColor)
        
        plusButton.set(cornerRadius: buttonsSize/2)
        minusButton.set(cornerRadius: buttonsSize/2)
    }
    
    
    private func configureGoalLabel() {
        
        goalLabel.text = "200 cl"

    }
    
    
    private func layoutUI() {
        view.addSubview(goalTitleLabel)
        view.addSubview(plusButton)
        view.addSubview(stackView)

        goalTitleLabel.text = "🎯 Daily goal"
        
        let padding: CGFloat = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            goalTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            goalTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            goalTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            
        //    stackView.topAnchor.constraint(equalTo: goalTitleLabel.bottomAnchor, constant: 0),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 140),
            stackView.heightAnchor.constraint(equalToConstant: 25),
            
//            plusButton.topAnchor.constraint(equalTo: goalTitleLabel.bottomAnchor, constant: 20),
//            plusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            plusButton.widthAnchor.constraint(equalToConstant: buttonsSize),
//            plusButton.heightAnchor.constraint(equalToConstant: buttonsSize)

//            weightPicker.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 0),
//            weightPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            weightPicker.widthAnchor.constraint(equalToConstant: 80),
//            weightPicker.heightAnchor.constraint(equalToConstant: 80),
//
//            unitLabel.centerYAnchor.constraint(equalTo: weightPicker.centerYAnchor),
//            unitLabel.leadingAnchor.constraint(equalTo: weightPicker.trailingAnchor, constant: 0),
//            unitLabel.heightAnchor.constraint(equalToConstant: 20),

        ])
        
        
    }
    
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        NSLayoutConstraint.activate([
            plusButton.widthAnchor.constraint(equalToConstant: buttonsSize),
            plusButton.heightAnchor.constraint(equalToConstant: buttonsSize),
            minusButton.widthAnchor.constraint(equalToConstant: buttonsSize),
            minusButton.heightAnchor.constraint(equalToConstant: buttonsSize),
        ])
        
        stackView.addArrangedSubview(plusButton)
        stackView.addArrangedSubview(goalLabel)
        stackView.addArrangedSubview(minusButton)
    }
}
