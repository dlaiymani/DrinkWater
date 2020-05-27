//
//  DateVC.swift
//  DrinkWater
//
//  Created by David Laiymani on 26/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class DateVC: UIViewController {
    
    var todayLabel = DWBoldLabel(textAlignment: .left, fontSize: 17)
    var dateLabel = DWTitleLabel(textAlignment: .center, fontSize: 17)
    let stackView = UIStackView()
        
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewElements()
        configureStackView()
        layoutUI()
    }

    
    private func configureViewElements() {
        todayLabel.text = "Today, "
        dateLabel.text = Date().convertToDayMonthYearFormat()
    }

    
    private func configureStackView() {
        view.addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
    }

    
    private func layoutUI() {
        stackView.addArrangedSubview(todayLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
}
