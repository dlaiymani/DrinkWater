//
//  ChartsFormatter.swift
//  DrinkWater
//
//  Created by David Laiymani on 18/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit
import Foundation
import Charts

@objc(BarChartFormatter)
public class LineChartFormatter: NSObject, IAxisValueFormatter
{
  var months: [String]! = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    return months[Int(value)]
  }
}
