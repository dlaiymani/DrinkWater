//
//  DWWeekView.swift
//  DrinkWater
//
//  Created by David Laiymani on 06/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class DWDayView: UIView {

    var circlePath: UIBezierPath!
    var shadowPath: UIBezierPath!
    var lineWidth = 3.0
    let shadowShapelayer = CAShapeLayer()
    let circleShapeLayer = CAShapeLayer()
    let textLayer = LCTextLayer()
    
    var percentageCompleted = 0.0
    var todayInInt = Date().getWeekDay()

    
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    var padding: CGFloat = 20.0

     
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        self.backgroundColor = UIColor.black
//        setWeekDays()
//        drawShadowCircle()
    }
    
     
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
        
//    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, percentageCompleted: Double, dayInInt: Int) {
//        super.init(frame: .zero)
//
//        self.width = width
//        self.height = height
//        self.dayInInt = dayInInt
//
//        self.frame = CGRect(x: x, y: y, width: width, height: height+CGFloat(self.padding))
//        self.backgroundColor = UIColor.black
//
//        if self.todayInInt == self.dayInInt {
//            self.percentageCompleted = percentageCompleted
//        } else {
//            self.percentageCompleted = 0.0
//        }
//
//        setWeekDays()
//        drawShadowCircle()
//    }
    
    
    func drawWeekDays(day: Int) {
        textLayer.string = day.convertToDayLetter()
            
        if self.todayInInt == day {
            textLayer.foregroundColor = UIColor.white.cgColor
            textLayer.backgroundColor = DWColors.greenColor
        } else {
            textLayer.foregroundColor = UIColor.white.cgColor
            textLayer.backgroundColor = UIColor.clear.cgColor
        }
        
        textLayer.font = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
        textLayer.fontSize = 12.0
        textLayer.cornerRadius = 8
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.frame = CGRect(x: 10.0, y: 0, width: 16.0, height: 16.0)
        textLayer.contentsScale = UIScreen.main.scale
        self.layer.addSublayer(textLayer)
        drawShadowCircle()
    }
    
    
    
//    private func setWeekDays() {
//        textLayer.string = self.dayInInt.convertToDayLetter()
//
//        if self.todayInInt == self.dayInInt {
//            textLayer.foregroundColor = UIColor.white.cgColor
//            textLayer.backgroundColor = DWColors.greenColor
//        } else {
//            textLayer.foregroundColor = UIColor.white.cgColor
//            textLayer.backgroundColor = UIColor.clear.cgColor
//        }
//
//        textLayer.font = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
//        textLayer.fontSize = 12.0
//        textLayer.cornerRadius = 8
//        textLayer.alignmentMode = CATextLayerAlignmentMode.center
//        textLayer.frame = CGRect(x: 8.0, y: 0, width: 16.0, height: 16.0)
//        textLayer.contentsScale = UIScreen.main.scale
//        self.layer.addSublayer(textLayer)
//
//    }
    
    private func drawShadowCircle() {
        
        width = frame.size.width
        height = frame.size.height
        
        shadowPath = UIBezierPath(arcCenter: CGPoint(x: (width-padding)/2, y: (height/2)+padding),
        radius: (width-padding)/2,
        startAngle: -CGFloat.pi/2,
        endAngle: 2*CGFloat.pi,
        clockwise: true)
        
        shadowShapelayer.path = shadowPath.cgPath
        shadowShapelayer.fillColor = UIColor.clear.cgColor
        shadowShapelayer.strokeColor = DWColors.lightGreenColor
        shadowShapelayer.lineWidth = CGFloat(lineWidth)
        shadowShapelayer.lineCap = .round
                          
        self.layer.addSublayer(shadowShapelayer)
        
    }
    
    
    func drawActivityCircle(day: Int, percentage: Double) {
        
        if todayInInt == day {
            self.percentageCompleted = percentage
        } else {
            self.percentageCompleted = 0.0
        }
        
        var endAngle = percentageCompleted*360.0 - 90.0
        if endAngle == 270.0 {
            endAngle = 269.0
        }

        self.circlePath = UIBezierPath(arcCenter: CGPoint(x: (width-padding)/2, y: (height/2)+self.padding),
        radius: (width-padding)/2,
        startAngle: CGFloat(270.0).toRadians(),
        endAngle: CGFloat(endAngle).toRadians(),
        clockwise: true)

        circleShapeLayer.path = self.circlePath.cgPath
        circleShapeLayer.fillColor = UIColor.clear.cgColor
        circleShapeLayer.strokeColor = DWColors.greenColor
        circleShapeLayer.lineWidth = CGFloat(lineWidth)
        circleShapeLayer.lineCap = .round
     
        self.layer.addSublayer(circleShapeLayer)
        
    }
    
    
//    func drawActivityCircle(percentage: Double) {
//
//        if self.todayInInt == self.dayInInt {
//            self.percentageCompleted = percentage
//        } else {
//            self.percentageCompleted = 0.0
//        }
//
//        var endAngle = percentageCompleted*360.0 - 90.0
//        if endAngle == 270.0 {
//            endAngle = 269.0
//        }
//
//        self.circlePath = UIBezierPath(arcCenter: CGPoint(x: width/2, y: (height/2)+self.padding),
//        radius: width/2,
//        startAngle: CGFloat(270.0).toRadians(),
//        endAngle: CGFloat(endAngle).toRadians(),
//        clockwise: true)
//
//        circleShapeLayer.path = self.circlePath.cgPath
//        circleShapeLayer.fillColor = UIColor.clear.cgColor
//        circleShapeLayer.strokeColor = DWColors.greenColor
//        circleShapeLayer.lineWidth = CGFloat(lineWidth)
//        circleShapeLayer.lineCap = .round
//
//        self.layer.addSublayer(circleShapeLayer)
//
//    }
    
}

