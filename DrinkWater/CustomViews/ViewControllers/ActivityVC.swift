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
        
     //   activityView = DWActivityView(x: self.view.frame.size.width/2 - width/2, y: self.view.frame.size.height/2 - height/2, width: width, height: height, percentageCompleted: 0.0)
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
    


//func configureActivityView() {
//        let width: CGFloat = self.view.frame.size.width/1.5
//        let height: CGFloat = width
//
//        percentageGoal = (drunkVolume*100)/drinkGoal
//        self.radius = Double(width / 2.0)
//
//        activityView = DWActivityView(x: self.view.frame.size.width/2 - width/2, y: self.view.frame.size.height/2 - height/2, width: width, height: height, percentageCompleted: percentageGoal)
//
//        self.view.addSubview(activityView)
//    }

}
