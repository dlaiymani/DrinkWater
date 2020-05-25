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
    let maleButton = DWButton(backgroundColor: DWColors.greenColor, title: "M")
    let femaleButton = DWButton(backgroundColor: DWColors.whiteColor, title: "F")
    let stackView = UIStackView()
    
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
        configureSexButtons()
        configureStackView()
        layoutUI()        
    }
    
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = UIColor(cgColor: DWColors.lightBlackColor)
    }
    
    private func configureSexButtons() {
        femaleButton.set(textColor: DWColors.grayColor)
        
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
            
            stackView.topAnchor.constraint(equalTo: sexLabel.bottomAnchor, constant: padding),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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

