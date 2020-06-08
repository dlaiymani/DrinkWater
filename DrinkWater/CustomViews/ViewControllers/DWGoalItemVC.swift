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
    var units: DWUnits = .cl
    var unitsString = "cl"
    
    var segmentedCtrl: UISegmentedControl!

    
    init(profile: User) {
        super.init(nibName: nil, bundle: nil)
        user = profile
        goal = user.dailyGoal
        units = user.units
        if units == .cl {
            unitsString = "cl"
        } else {
            unitsString = "oz"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureGoalLabel()
        configureButtons()

        layoutUI()
        configureStackView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        configureSegmentedControl()
        
    }
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = UIColor(cgColor: DWColors.lightBlackColor)
    }
    
    func configureSegmentedControl() {
        if units == .cl {
            segmentedCtrl.selectedSegmentIndex = 0
        } else {
            segmentedCtrl.selectedSegmentIndex = 1
        }
    }
    
    private func configureButtons() {
        plusButton.set(textColor: DWColors.blackColor)
        minusButton.set(textColor: DWColors.blackColor)
        
        plusButton.set(cornerRadius: buttonsSize/2)
        minusButton.set(cornerRadius: buttonsSize/2)
        
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        
        let items = ["cl", "oz"]
        segmentedCtrl = UISegmentedControl(items: items)
        
        
        segmentedCtrl.layer.cornerRadius = 40.0
        segmentedCtrl.backgroundColor = UIColor.white
        segmentedCtrl.tintColor = UIColor(cgColor: DWColors.greenColor)
        segmentedCtrl.selectedSegmentTintColor = UIColor(cgColor: DWColors.greenColor)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)

        segmentedCtrl.addTarget(self, action: #selector(self.changeUnits), for: .valueChanged)
    }
    
    
    @objc func changeUnits() {
        print(segmentedCtrl.selectedSegmentIndex)
        if segmentedCtrl.selectedSegmentIndex == 0 {
            if units == .oz {
                goal = goal * 3.0
            }
            units = .cl
            unitsString = "cl"

        } else {
            if units == .cl {
                goal = goal * 0.3333333333333
            }
            units = .oz
            unitsString = "oz"
        }
        
        goalLabel.text = "\(String(format: "%.2f", goal)) \(unitsString)"
    }
    
    @objc private func plusButtonTapped() {
        goal += 10
        goalLabel.text = "\(String(format: "%.2f", goal)) \(unitsString)"
        
    }
    
    
    @objc private func minusButtonTapped() {
        goal -= 10
        goalLabel.text = "\(String(format: "%.2f", goal)) \(unitsString)"

    }
    
    
    private func configureGoalLabel() {
        
        goalLabel.text = "\(String(format: "%.2f", goal)) \(unitsString)"

    }
    
    
    private func layoutUI() {
        view.addSubview(goalTitleLabel)
       // view.addSubview(plusButton)
        view.addSubview(stackView)
        
        view.addSubview(segmentedCtrl)
        segmentedCtrl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedCtrl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedCtrl.widthAnchor.constraint(equalToConstant: 100),
            segmentedCtrl.heightAnchor.constraint(equalToConstant: 25)
        ])

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
        
        
        let space1 = UILayoutGuide()
        self.view.addLayoutGuide(space1)
         
        let space2 = UILayoutGuide()
        self.view.addLayoutGuide(space2)

        space1.heightAnchor.constraint(equalTo: space2.heightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: space1.topAnchor).isActive = true
        segmentedCtrl.topAnchor.constraint(equalTo: space1.bottomAnchor).isActive = true
        segmentedCtrl.bottomAnchor.constraint(equalTo: space2.topAnchor).isActive = true
        space2.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        segmentedCtrl.layoutIfNeeded()
        
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
