//
//  DWNotifsItemVC.swift
//  DrinkWater
//
//  Created by David Laiymani on 27/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class DWNotifsItemVC: UIViewController {
    
    let notifTitleLabel = DWTitleLabel(textAlignment: .left, fontSize: 15)
    let nbNotifsLabel = DWTitleLabel(textAlignment: .left, fontSize: 18)
    let plusButton = DWButton(backgroundColor: DWColors.greenColor, title: "+")
    let minusButton = DWButton(backgroundColor: DWColors.greenColor, title: "-")
    
    let stackView = UIStackView()
    
    let goal = 3
    private let buttonsSize: CGFloat = 25
    
    var user: User!
    
    init() {
        super.init(nibName: nil, bundle: nil)
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
        
        nbNotifsLabel.text = "3"

    }
    
    
    private func layoutUI() {
        view.addSubview(notifTitleLabel)
       // view.addSubview(plusButton)
        view.addSubview(stackView)

        notifTitleLabel.text = "🔔 Notifications / day"
        
        let padding: CGFloat = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            notifTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            notifTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            notifTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            
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
        stackView.addArrangedSubview(nbNotifsLabel)
        stackView.addArrangedSubview(plusButton)
    }
}

