//
//  DWActivityView.swift
//  DrinkWater
//
//  Created by David Laiymani on 06/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit


class DWActivityView: UIView {

    var circlePath: UIBezierPath!
    var shadowPath: UIBezierPath!
    var pulsatingPath: UIBezierPath!
    var lineWidth = 30.0
    var circleShapeLayer = CAShapeLayer()
    var pulsatingLayer = CAShapeLayer()
    var shadowShapelayer = CAShapeLayer()
    
    let activityLabelStackView = UIStackView()
    let goalAndActivityStackView = UIStackView()
    var activityLevelLabel = DWBoldLabel(textAlignment: .left, fontSize: 15)
    var simpleDescLabel = DWTitleLabel(textAlignment: .center, fontSize: 15)
    var congratLabel = DWBoldLabel(textAlignment: .center, fontSize: 15)
    var goalLabel = DWTitleLabel(textAlignment: .center, fontSize: 15)

    var percentageCompleted = 0.0
    var goal = 0.0
    var unit: DWUnits!
   
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
     
    
    var startValue = 0.0
    var endValue = 0.0
    let animationDuration: Double = 1.0
    var animationStartDate = Date()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        self.backgroundColor = UIColor.black
    }
    
     
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [unowned self] notification in
            self.animatePusaltingCircle()
        }
    }
    
    
    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, percentageCompleted: Double) {
        super.init(frame: .zero)
        
        self.percentageCompleted = percentageCompleted
        self.width = width
        self.height = height
                
        setupNotificationObservers()
        
        self.frame = CGRect(x: x, y: y+25, width: width, height: height)
        self.backgroundColor = UIColor.black
        
        endValue = percentageCompleted*100
        
        drawPulsatingCircle()
        drawShadowCircle()
        configureActivityLabel()
    }
    
    
    private func drawShadowCircle() {
        self.shadowPath = UIBezierPath(arcCenter: CGPoint(x: width/2, y: (height/2)),
        radius: width/2,
        startAngle: -CGFloat.pi/2,
        endAngle: 2*CGFloat.pi,
        clockwise: true)
        
        shadowShapelayer.path = self.shadowPath.cgPath
        shadowShapelayer.fillColor = UIColor.clear.cgColor
        shadowShapelayer.strokeColor = DWColors.lightGreenColor
        shadowShapelayer.lineWidth = CGFloat(lineWidth)
        shadowShapelayer.lineCap = .round

        self.layer.addSublayer(shadowShapelayer)
    }
    
    
    func updateActivityCircle(percentage: Double) {
        
        var endAngle = percentage*360.0 - 90.0
        if endAngle == 270.0 {
            endAngle = 269.0
        }
        
        self.circlePath = UIBezierPath(arcCenter: CGPoint(x: width/2, y: (height/2)),
        radius: width/2,
        startAngle: CGFloat(270.0).toRadians(),
        endAngle: CGFloat(endAngle).toRadians(),
        clockwise: true)
        
        circleShapeLayer.path = self.circlePath.cgPath
        circleShapeLayer.fillColor = UIColor.clear.cgColor
        circleShapeLayer.strokeColor = DWColors.greenColor
        circleShapeLayer.lineWidth = CGFloat(lineWidth)
        circleShapeLayer.lineCap = .round
            
        self.layer.addSublayer(circleShapeLayer)
        animateActivityCircle()
    }
    
    
    private func animateActivityCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.fromValue = 0
        basicAnimation.toValue = 1
        basicAnimation.duration = 1
        
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        circleShapeLayer.add(basicAnimation, forKey: "simpleAnim")
    }
    
    
    private func drawPulsatingCircle() {
        
        pulsatingPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0),
        radius: width/2,
        startAngle: -CGFloat.pi/2,
        endAngle: 2*CGFloat.pi,
        clockwise: true)
        
        pulsatingLayer.path = self.pulsatingPath.cgPath
        pulsatingLayer.fillColor = UIColor.clear.cgColor
        pulsatingLayer.strokeColor = DWColors.pulsatingGreenColor
        pulsatingLayer.lineWidth = CGFloat(lineWidth)
        pulsatingLayer.lineCap = .round
        pulsatingLayer.position = CGPoint(x: width/2, y: (height/2))
        self.layer.addSublayer(pulsatingLayer)
        
    }
    
    
    func animatePusaltingCircle() {
        
        pulsatingLayer.removeAllAnimations()
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 1.2
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
    
        pulsatingLayer.add(animation, forKey: "pulseAnim")
    }
    
    
    private func configureActivityLabel() {
        
        self.addSubview(activityLabelStackView)
        congratLabel.isHidden = true
        activityLabelStackView.isHidden = false
        activityLabelStackView.axis = .horizontal
        activityLabelStackView.distribution = .equalSpacing
        activityLabelStackView.addArrangedSubview(activityLevelLabel)
        activityLabelStackView.addArrangedSubview(simpleDescLabel)
        activityLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(goalAndActivityStackView)
        goalAndActivityStackView.axis = .vertical
        goalAndActivityStackView.distribution = .equalSpacing
        goalAndActivityStackView.addArrangedSubview(activityLabelStackView)
        goalAndActivityStackView.addArrangedSubview(goalLabel)
        goalAndActivityStackView.translatesAutoresizingMaskIntoConstraints = false

        
        simpleDescLabel.text = "daily goal"
        goalLabel.text = ""
        
        NSLayoutConstraint.activate([
//            activityLabelStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            activityLabelStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            goalAndActivityStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            goalAndActivityStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    
    func configureCongratLabel() {
        
        self.addSubview(congratLabel)
        activityLabelStackView.isHidden = true
        congratLabel.isHidden = false

        congratLabel.text = "Congratulations !!"
        
        NSLayoutConstraint.activate([
            congratLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            congratLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    
    func animateActivityLabel(percentage: Double, goal: Double, unit: DWUnits) {
        endValue = percentage*100
        animationStartDate = Date()
        self.goal = goal
        self.unit = unit

        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink.add(to: .main, forMode: .default)
    }
    
    
    
    @objc func handleUpdate() {
    
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        
        if elapsedTime > animationDuration {
            self.activityLevelLabel.text = "\(Int(endValue))% "
            let drinked = goal*endValue/100
            self.goalLabel.text = "\(String(format: "%.f", goal-drinked)) \(unit.rawValue) left"
        } else {
            let percentage = elapsedTime / animationDuration
            let value = percentage * (endValue - startValue)
            activityLevelLabel.text = "\(Int(value))% "

        }
    }
}

