//
//  DWItemInfoVC.swift
//  DrinkWater
//
//  Created by David Laiymani on 20/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class DWItemInfoVC: UIViewController {
    
    let stackView = UIStackView()
    let itemInfoOne = DWItemInfoView()
    let itemInfoTwo = DWItemInfoView()
    let itemInfoThree = DWItemInfoView()
    let itemInfoFour = DWItemInfoView()
    let actionButton = DWButton()
    
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
        layoutUI()
        configureStackView()
        configureActionButton()
    }
    
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = UIColor(cgColor: DWColors.lightBlackColor)
    }
    
    
    private func layoutUI() {
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
//            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
//            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.widthAnchor.constraint(equalToConstant: view.frame.width-(4*padding)),
            
            
            actionButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding),
//            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2*padding),
//            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2*padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
            actionButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            actionButton.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
    
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoOne)
        stackView.addArrangedSubview(itemInfoTwo)
       // stackView.addArrangedSubview(itemInfoThree)
        stackView.addArrangedSubview(itemInfoFour)
    }
    
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func actionButtonTapped() {
        
    }

}
