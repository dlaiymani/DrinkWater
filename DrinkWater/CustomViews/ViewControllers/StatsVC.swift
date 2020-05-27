//
//  StatsVC.swift
//  DrinkWater
//
//  Created by David Laiymani on 27/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class StatsVC: UIViewController {
    
    var statsLabel = DWTitleLabel(textAlignment: .center, fontSize: 17)
    var statsBoldLabel = DWBoldLabel(textAlignment: .left, fontSize: 17)

    private var statsStackView = UIStackView()
    var swipeDownLabel = DWTitleLabel(textAlignment: .center, fontSize: 17)
    let yearVC = YearStatsVC()
    
    var segmentedCtrl: UISegmentedControl!

    var downSwipe: UISwipeGestureRecognizer!

        
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewElements()
        layoutUI()
    }

    
    
    private func configureViewElements() {
        configureStatsLabel()
        
        view.backgroundColor = .black
        statsBoldLabel.text = "Week "

        let items = ["Week", "Month", "Year"]
        segmentedCtrl = UISegmentedControl(items: items)
        segmentedCtrl.selectedSegmentIndex = 0

//        let frame = UIScreen.mainScreen().bounds
//        customSC.frame = CGRectMake(frame.minX + 10, frame.minY + 50,
//                                    frame.width - 20, frame.height*0.1)

        segmentedCtrl.layer.cornerRadius = 40.0
        segmentedCtrl.backgroundColor = UIColor.white
        segmentedCtrl.tintColor = UIColor(cgColor: DWColors.greenColor)
        segmentedCtrl.selectedSegmentTintColor = UIColor(cgColor: DWColors.greenColor)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)

        segmentedCtrl.addTarget(self, action: Selector("changeStats"), for: .valueChanged)

        // Add this custom Segmented Control to our view
        
        configureSwipeDownMessage()
    }

    
    @objc func changeStats() {
        switch segmentedCtrl.selectedSegmentIndex {
        case 0:
            yearVC.statsType = .week
            statsBoldLabel.text = "Week "
            yearVC.setData()
        case 1:
            yearVC.statsType = .month
            statsBoldLabel.text = "Month "
            yearVC.setData()

        case 2:
            yearVC.statsType = .year
            statsBoldLabel.text = "Year "
            yearVC.setData()
        default:
            print("error")
        }
    }
    
    private func configureStatsLabel() {
        view.addSubview(statsStackView)
           
        statsLabel.text = "achievements"
        
        statsStackView.axis = .horizontal
        statsStackView.distribution = .equalSpacing
        statsStackView.addArrangedSubview(statsBoldLabel)
        statsStackView.addArrangedSubview(statsLabel)
        statsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 40)
        ])
    }
    
    
    func layoutUI() {
        view.addSubview(yearVC.view)
        yearVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            yearVC.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            yearVC.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            yearVC.view.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.2),
            yearVC.view.heightAnchor.constraint(equalToConstant: view.frame.size.width/1.2)

        ])
        
        view.addSubview(segmentedCtrl)
        segmentedCtrl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedCtrl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        configureSwipeDownMessage()

        let space1 = UILayoutGuide()
        self.view.addLayoutGuide(space1)
         
        let space2 = UILayoutGuide()
        self.view.addLayoutGuide(space2)

        space1.heightAnchor.constraint(equalTo: space2.heightAnchor).isActive = true
        yearVC.view.bottomAnchor.constraint(equalTo: space1.topAnchor).isActive = true
        segmentedCtrl.topAnchor.constraint(equalTo: space1.bottomAnchor).isActive = true
        segmentedCtrl.bottomAnchor.constraint(equalTo: space2.topAnchor).isActive = true
        swipeDownLabel.topAnchor.constraint(equalTo: space2.bottomAnchor, constant: 0).isActive = true
        
        segmentedCtrl.layoutIfNeeded()

    }
    
    private func configureSwipeDownMessage() {
        view.addSubview(swipeDownLabel)
        swipeDownLabel.text = "Swipe down to drink."
        NSLayoutConstraint.activate([
            swipeDownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swipeDownLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
    
    
    
    private func configureSwipeDownGesture() {
        downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown))
        downSwipe.direction = .down
    }
    
    
    @objc func handleSwipeDown() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        self.addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

}
