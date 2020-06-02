//
//  GFErrors.swift
//  DrinkWater
//
//  Created by David Laiymani on 29/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import Foundation

enum DWErrors: String, Error {
    case unableToSaveProfile = "There was an error saving this user profile. Please try again"
    case unableToGetProfile = "There was an error getting this user profile. Please try again"
}
