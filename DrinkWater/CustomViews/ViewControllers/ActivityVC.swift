//
//  ActivityVC.swift
//  DrinkWater
//
//  Created by David Laiymani on 26/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class ActivityVC: UIViewController {
    
    var activityView: DWActivityView!
    
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    
    var percentageCompleted: Double = 0.0
    
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
        width = view.frame.size.width/1.5
        height = view.frame.size.width/1.5
        
        activityView = DWActivityView(x: 0, y: 0, width: width, height: height, percentageCompleted: 0.0)
        self.view.addSubview(activityView)
    }
    
    private func layoutUI() {
        
        activityView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityView.topAnchor.constraint(equalTo: view.topAnchor),
            activityView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityView.widthAnchor.constraint(equalToConstant: width),
            activityView.heightAnchor.constraint(equalToConstant: height),
        ])
    }
    
    
    func animateCircles(for percentageGoal: Double) {
//        if percentageGoal >= 1.0 {
//            percentageGoal = 1.0
//            goalCompleted = true
//            self.actionButton.disableActionButton()
        //    self.activityView.animatePusaltingCircle()
       // }
        activityView.animateActivityLabel(percentage: percentageGoal)
        activityView.updateActivityCircle(percentage: percentageGoal)
       // updateWeekView()
    }

    
    func animatePulsatingCircle() {
        activityView.animatePusaltingCircle()
    }

}
