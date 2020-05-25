//
//  DWLinesChartView.swift
//  DrinkWater
//
//  Created by David Laiymani on 18/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import Foundation
import Macaw

// TODO :
// - Attention quand retour d'arrière plan -> pulsating anim se lance même si 0%

class DWLinesChartView: MacawView {

    private let currentYearStats = createDummyStats()
    private let maxValue = 100.0
    private let maxValueLineHeight = 200.0
    private let lineWidth = 275
    
    private let dataDiviser = 0.5
    private var adjustedData: [Double] = []

    //private static let cubicCurve = CubicCurveAlgorithm()
    private var animationRect = Shape(form: Rect())
    
    private var animations = [Animation]()

    
    private let leftGradientColor = 0xff7200
    private let rightGradientColor = 0xffff86


//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.backgroundColor = .black
//        DWLinesChartView.centerX = Double(self.frame.size.width / 2)
//        DWLinesChartView.width = Double(self.frame.width)
//
//        self.node = DWLinesChartView.createLinesChart()
//
//    }

 
    required init?(coder aDecoder: NSCoder) {
        super.init(node: Node(), coder: aDecoder)
    }
    
    
//    private func createLinesChart() -> Group {
//
//        var items: [Node] = addXAxisItems() + addYAxisItems() + addShadowBars()
//        items.append(createLines())
//
//        return Group(contents: items, place: .identity)
//    }
    
    
    private func addXAxisItems() -> Group {
        let chartBaseY: Double = 200
        var newNodes: [Node] = []

        for i in 0...adjustedData.count-1 {
            let x = (Double(i)*35)
            let valueText = Text(text: "\(currentYearStats[i].day)",
                font: Font(name: "SanFrancisco", size: 15),
                align: .max, baseline: .mid, place: .move(dx: x, dy: chartBaseY + 15))
            valueText.fill = Color.white
            newNodes.append(valueText)
        }
        
        return newNodes.group()
    }
    
    private func addShadowBars() -> Group {
        var newNodes: [Node] = []
        let height = 200.0
        
        for i in 0...adjustedData.count-1 {
            let rect = Rect(x: Double(i)*35, y: 200-height, w: 2, h: height)
            let shape = Shape(form: RoundRect(rect: rect, rx: 5, ry: 5), fill: Color(val: 0x12201f).with(a: 1))
                
            newNodes.append(shape)
        }
        return newNodes.group()

    }
    
    
    private func addYAxisItems() -> Group {
        let maxLines = 4
        let lineInterval = Int(maxValue/Double(maxLines))
        let yAxisHeight: Double = 200
        let lineSpacing: Double = 50
        
        var newNodes: [Node] = []
        
        for i in 1...maxLines {
            let y = yAxisHeight - (Double(i) * lineSpacing)
            let valueLine = Line(x1: -5, y1: y, x2: Double(lineWidth), y2: y).stroke(fill: Color.white.with(a: 0.5))
            let valueText = Text(text: "\(i*lineInterval)", align: .max, baseline: .mid, place: .move(dx: -10, dy: y))
            valueText.fill = Color.white
           // newNodes.append(valueLine)
            newNodes.append(valueText)
        }
        
        let yAxis = Line(x1: 0, y1: 0, x2: 0, y2: yAxisHeight).stroke(fill: Color.white.with(a: 0.25))
        newNodes.append(yAxis)
        
        return newNodes.group()
    }

    
    private func createScene()  {

        adjustedData = currentYearStats.map { $0.drunkVolume / Double(dataDiviser) }

        let chartLinesGroup = Group()
      //  chartLinesGroup.place = Transform.move(dx: 0, dy: 0)
    
        var dataPoints: [CGPoint] = []
        adjustedData.enumerated().map {(i: Int, item: Double) in
            dataPoints.append(CGPoint(x: Double(i)*35, y: 200-item))
        }
        
      //  let controlPoints = self.cubicCurve.controlPointsFromPoints(dataPoints: dataPoints)
        var path: PathBuilder = MoveTo(x: Double(dataPoints[0].x), y: Double(dataPoints[0].y))
        for index in 0...dataPoints.count - 2 {
            path = path.lineTo(x: Double(dataPoints[index + 1].x), y: Double(dataPoints[index + 1].y))
//        path = path.cubicTo(
//                x1: Double(controlPoints[index].controlPoint1.x),
//                y1: Double(controlPoints[index].controlPoint1.y),
//                x2: Double(controlPoints[index].controlPoint2.x),
//                y2: Double(controlPoints[index].controlPoint2.y),
//                x: Double(dataPoints[index + 1].x),
//                y: Double(dataPoints[index + 1].y)
//            )
        }
        
        let shape = Shape(
            form: path.build(),
            stroke: Stroke(
            fill: LinearGradient(degree: 0, from: Color(val: 0xff7200), to: Color(val: 0xffff86)),
                    width: 2
            )
        )
        chartLinesGroup.contents.append(shape)

        animationRect = Shape(
                   form: Rect(x: 0, y: -1, w: Double(386), h: Double(200)),
                   fill: Color(val: 0x000000).with(a: 1.0)
               )
       chartLinesGroup.contents.append(animationRect)
        
        let chartGroup = [addXAxisItems(), addYAxisItems(), addShadowBars(), chartLinesGroup]
        self.node = chartGroup.group()
        
    }
    
    
    private func createAnimations() {
        animations.removeAll()
        animations.append(
            animationRect.placeVar.animation(to: Transform.move(dx: 100, dy: 0), during: 2)
        )
    }
    
     func playAnimations() {
        createScene()
        createAnimations()
        animations.forEach {
           $0.play()
        }
    }
    
            
//       adjustedData.forEach { scoreLine in
//           let dataPoints = scoreLine.points.map { CGPoint(x: $0.x, y: $0.y) }
//           let controlPoints = self.cubicCurve.controlPointsFromPoints(dataPoints: dataPoints)
//           var path: PathBuilder = MoveTo(x: scoreLine.points[0].x, y: scoreLine.points[0].y)
//           for index in 0...dataPoints.count - 2 {
//               path = path.cubicTo(
//                   x1: Double(controlPoints[index].controlPoint1.x),
//                   y1: Double(controlPoints[index].controlPoint1.y),
//                   x2: Double(controlPoints[index].controlPoint2.x),
//                   y2: Double(controlPoints[index].controlPoint2.y),
//                   x: Double(dataPoints[index + 1].x),
//                   y: Double(dataPoints[index + 1].y)
//               )
//           }
//           let shape = Shape(
//               form: path.build(),
//               stroke: Stroke(
//                   fill: LinearGradient(degree: 0, from: Color(val: scoreLine.leftGradientColor), to: Color(val: scoreLine.rightGradientColor)),
//                   width: 2
//               )
//           )
//           chartLinesGroup.contents.append(shape)
//       }
//
//       animationRect = Shape(
//           form: Rect(x: 0, y: 0, w: Double(chartWidth + 1), h: Double(chartHeight + backgroundLineSpacing)),
//           fill: Color(val: 0x4a2e7d)
//       )
//       chartLinesGroup.contents.append(animationRect)
//        return items.group()}
    
    
    private static func createDummyStats() -> [DayDrink] {
        let january = DayDrink(day: "J", drunkVolume: 70.0)
        let february = DayDrink(day: "F", drunkVolume: 50.0)
        let march = DayDrink(day: "M", drunkVolume: 100.0)
        let april = DayDrink(day: "A", drunkVolume: 80.0)
        let may = DayDrink(day: "M", drunkVolume: 20.0)
        let june = DayDrink(day: "J", drunkVolume: 70.0)
        let july = DayDrink(day: "J", drunkVolume: 100.0)
        let august = DayDrink(day: "A", drunkVolume: 100.0)
        let september = DayDrink(day: "S", drunkVolume: 40.0)
        let october = DayDrink(day: "O", drunkVolume: 60.0)
        let november = DayDrink(day: "N", drunkVolume: 80.0)
        let december = DayDrink(day: "D", drunkVolume: 100.0)

        return [january, february, march, april, may, june, july, august, september, october,
                november, december]

    }
}
