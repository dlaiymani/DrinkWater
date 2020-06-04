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
    
    var goal = 1200.0
    var user: User!
    private let buttonsSize: CGFloat = 25
    
    init(profile: User) {
        super.init(nibName: nil, bundle: nil)
        user = profile
        goal = user.dailyGoal
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
        
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
    }
    
    
    @objc private func plusButtonTapped() {
        goal += 10
        goalLabel.text = "\(goal) cl"
        
    }
    
    
    @objc private func minusButtonTapped() {
        goal -= 10
        goalLabel.text = "\(goal) cl"

    }
    
    
    private func configureGoalLabel() {
        
        goalLabel.text = "\(goal) cl"

    }
    
    
    private func layoutUI() {
        view.addSubview(goalTitleLabel)
       // view.addSubview(plusButton)
        view.addSubview(stackView)

        goalTitleLabel.text = "🎯 Daily goal"
        
        let padding: CGFloat = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            goalTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            goalTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            goalTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 140),
            stackView.heightAnchor.constraint(equalToConstant: 25),
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
        
        stackView.addArrangedSubview(minusButton)
        stackView.addArrangedSubview(goalLabel)
        stackView.addArrangedSubview(plusButton)
    }
}
