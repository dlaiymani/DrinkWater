//
//  User.swift
//  DrinkWater
//
//  Created by David Laiymani on 20/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import Foundation

struct User: Codable {
    var username: String?
    var name: String?
    var location: String?
    var age: Int?
    var weight: Double?
    var height: Double?
    var sport: Bool?
    var sex: String?
    var preferredDrinkSize: [Int]?
    let createdAt: String
}


