//
//  User.swift
//  DrinkWater
//
//  Created by David Laiymani on 20/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import Foundation

struct User: Codable {
    var yob: Int
    var weight: Double
    var sex: String
    var preferredDrinkSize: [Int]
    var dailyGoal: Double
    var units: DWUnits
    var nbOfNotifs: Int
}


