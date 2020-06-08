//
//  PreferedSizes.swift
//  DrinkWater
//
//  Created by David Laiymani on 08/06/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import Foundation


struct PreferedSizes: Codable {
    var prefArray = [DWGlassSizes]()
    
    func convertFrom(unit: DWUnits) -> [Double] {
        
        var convertedArray = [Double]()
        
        for size in prefArray {
            
            convertedArray.append(size.convert(to: unit))
//            if unit == .cl {
//                switch size  {
//                case .s:
//                    convertedArray.append(12.5)
//                case .m:
//                    convertedArray.append(25)
//                case .l:
//                    convertedArray.append(33)
//                case .xl:
//                    convertedArray.append(50)
//                case .xxl:
//                    convertedArray.append(100)
//                }
//            } else { // .oz
//                switch size  {
//                case .s:
//                    convertedArray.append(5)
//                case .m:
//                    convertedArray.append(12)
//                case .l:
//                    convertedArray.append(16.9)
//                case .xl:
//                    convertedArray.append(25.4)
//                case .xxl:
//                    convertedArray.append(33.8)
//                }
//            }
        }
        return convertedArray
    }
}
