//
//  StatsVC.swift
//  DrinkWater
//
//  Created by David Laiymani on 27/04/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class WeekStatsVC: UIViewController {
    
    var statsView: DWChartsView!
    private var statsLabel = DWTitleLabel(textAlignment: .center, fontSize: 17)
    private var statsBoldLabel = DWBoldLabel(textAlignment: .left, fontSize: 17)
    private var statsStackView = UIStackView()


    var width = 0.0
    var height = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        width = Double(view.frame.size.width/1.4)
        height = Double(view.frame.size.height/1.7)
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setStatsViewConstraints()
        configureStatsLabel()
        DWChartsView.playAnimations()
    }
    
    
    private func setStatsViewConstraints() {
        
        statsView = DWChartsView(frame: .zero)
        statsView.contentMode = .scaleAspectFit

        view.addSubview(statsView)

        statsView.translatesAutoresizingMaskIntoConstraints = false
               
        statsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        statsView.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
        statsView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        statsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    private func configureStatsLabel() {
        view.addSubview(statsStackView)
       
        statsBoldLabel.text = "Week "
        statsLabel.text = "achievements"
        
        statsStackView.axis = .horizontal
        statsStackView.distribution = .equalSpacing
        statsStackView.addArrangedSubview(statsBoldLabel)
        statsStackView.addArrangedSubview(statsLabel)
        statsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 0)
        ])
    }
    
    
    
}
