//
//  DWPersoItemVC.swift
//  DrinkWater
//
//  Created by David Laiymani on 20/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class DWPersoItemVC: DWItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()

    }
    
    
    private func configureItems() {
        itemInfoOne.set(itemInfoType: .age, withCount: String(user.age ?? 25))
        itemInfoTwo.set(itemInfoType: .sex, withCount: user.sex ?? "0")
       // itemInfoThree.set(itemInfoType: .height, withCount: String(user.height ?? 70))
        itemInfoFour.set(itemInfoType: .weight, withCount: String(user.weight ?? 70))

        actionButton.set(backgroundColor: DWColors.greenColor, title: "Edit")
    }
    
    
    override func actionButtonTapped() {
       // delegate.didTapGitHubProfile(for: user)
    }
}

