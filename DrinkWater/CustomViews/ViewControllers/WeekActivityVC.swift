//
//  WeekActivityVC.swift
//  DrinkWater
//
//  Created by David Laiymani on 26/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class WeekActivityVC: UIViewController {
    
    var dayViews: [DWDayView] = []
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
        configureDayViews()
        configureStackView()
        layoutUI()
    }
    

    func configureBackgroundView() {
        view.backgroundColor = UIColor.black
    }
    
    
    func configureDayViews() {
        for day in 0...6 {
            dayViews.append(DWDayView(day: day))
        }
    }
    
    
    func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        for dayView in dayViews {
            stackView.addArrangedSubview(dayView)
        }
    }
    
    
    func layoutUI() {
        let padding: CGFloat = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}



