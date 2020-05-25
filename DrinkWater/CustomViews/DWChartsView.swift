//
//  DWChartsView.swift
//  DrinkWater
//
//  Created by David Laiymani on 13/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import Foundation
import Macaw

// TODO :
// - Attention quand retour d'arrière plan -> pulsating anim se lance même si 0%

class DWChartsView: MacawView {
    
    static let currentWeekStats = createDummyStats()
    static let maxValue = 100.0
    static let maxValueLineHeight = 200.0
    static let lineWidth = 275
    
    static let dataDiviser = Double(maxValue/maxValueLineHeight)
    static let adjustedData = currentWeekStats.map { $0.drunkVolume / dataDiviser }
    static var animations: [Animation] = []
    static var animationsDelete: [Animation] = []

    static var centerX = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        DWChartsView.centerX = Double(self.frame.size.width / 2)
        
        self.node = DWChartsView.createChart()
        
    }
    
     
    required init?(coder aDecoder: NSCoder) {
        super.init(node: DWChartsView.createChart(), coder: aDecoder)
    }
    
    
    private static func createChart() -> Group {
        var items: [Node] = addXAxisItems()
        items += addShadowBars()
        items.append(createBars())

        return Group(contents: items, place: .identity)
    }
    
    
    private static func addShadowBars() -> [Node] {
        var newNodes: [Node] = []
        let height = 200.0
        
        for i in 0...adjustedData.count-1 {
            
           // let rect = Rect(x: Double(i)*35+25, y: 200-height, w: 10, h: height)
            let rect = Rect(x: Double(i)*35+25, y: 200-height, w: 10, h: height)

            let shape = Shape(form: RoundRect(rect: rect, rx: 5, ry: 5), fill: Color(val: 0x12201f).with(a: 0.6))
                
            newNodes.append(shape)
        }
        return newNodes

    }
    
    
    private static func addXAxisItems() -> [Node] {
        let chartBaseY: Double = 200
        var newNodes: [Node] = []

        for i in 1...adjustedData.count {
            let x = (Double(i)*35)
            let valueText = Text(text: "\(currentWeekStats[i-1].day)",
                font: Font(name: "SanFrancisco", size: 10),
                align: .max, baseline: .mid, place: .move(dx: x, dy: chartBaseY + 15))
            valueText.fill = Color.white
            newNodes.append(valueText)
        }
        
        return newNodes
    }
    
    
    private static func createBars() -> Group {

        let fill = LinearGradient(degree: 90, from: Color(val: 0x39e1d1).with(a: 0.7), to: Color(val: 0x39e1d1))
        let items = adjustedData.map { _ in Group() }
        
        animations = items.enumerated().map {(i: Int, item: Group) in
            item.contentsVar.animation(delay: Double(i)*0.1) { t in
                let height = adjustedData[i] * t
                let rect = Rect(x: Double(i)*35+25, y: 200-height, w: 10, h: height)
                let shape = Shape(form: RoundRect(rect: rect, rx: 5, ry: 5), fill: fill)
                return [shape]
            }
        }
        return items.group()
    }
    
    
    private static func addTitle() -> Node {
        
        let valueText = Text(text: "Week achievements",
            font: Font(name: "SanFrancisco", size: 10),
            align: .max, baseline: .mid, place: .move(dx: self.centerX, dy: -30))
        valueText.fill = Color.white
        return valueText
    }
    
    static func playAnimations() {
        animations.combine().play()
    }


    
    private static func createDummyStats() -> [DayDrink] {
        let monday = DayDrink(day: "M", drunkVolume: 70.0)
        let tuesday = DayDrink(day: "T", drunkVolume: 50.0)
        let wednsday = DayDrink(day: "W", drunkVolume: 100.0)
        let thursday = DayDrink(day: "T", drunkVolume: 80.0)
        let friday = DayDrink(day: "F", drunkVolume: 20.0)
        let saturday = DayDrink(day: "S", drunkVolume: 70.0)
        let sunday = DayDrink(day: "S", drunkVolume: 100.0)

        return [monday, tuesday, wednsday,thursday, friday, saturday, sunday]
    }
    
    
    
    private static func addYAxisItems() -> [Node] {
        let maxLines = 4
        let lineInterval = Int(maxValue/Double(maxLines))
        let yAxisHeight: Double = 180
        let lineSpacing: Double = 50
        
        var newNodes: [Node] = []
        
        for i in 1...maxLines {
            let y = yAxisHeight - (Double(i) * lineSpacing)
            let valueLine = Line(x1: -5, y1: y, x2: Double(lineWidth), y2: y).stroke(fill: Color.white.with(a: 0.1))
            let valueText = Text(text: "\(i*lineInterval)", align: .max, baseline: .mid, place: .move(dx: -10, dy: y))
            valueText.fill = Color.white
            newNodes.append(valueLine)
            newNodes.append(valueText)
        }
        
        let yAxis = Line(x1: 0, y1: 0, x2: 0, y2: yAxisHeight).stroke(fill: Color.white.with(a: 0.25))
        newNodes.append(yAxis)
        
        return newNodes
    }
}


