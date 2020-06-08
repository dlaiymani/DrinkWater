//
//  DWGlassSizes.swift
//  DrinkWater
//
//  Created by David Laiymani on 04/06/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import Foundation

enum DWGlassSizes: Int, Codable {
    
    case s
    case m
    case l
    case xl
    case xxl
    
    func convert(to unit: DWUnits) -> Double {
        if unit == .cl {
            switch self  {
            case .s:
                return(12.5)
            case .m:
                return(25)
            case .l:
                return(33)
            case .xl:
                return(50)
            case .xxl:
                return(100)
            }
        } else { // .oz
            switch self  {
            case .s:
                return(5)
            case .m:
                return(12)
            case .l:
                return(16.9)
            case .xl:
                return(25.4)
            case .xxl:
                return(33.8)
            }
        }
    }
}
