//
//  DrinkVC.swift
//  DrinkWater
//
//  Created by David Laiymani on 27/04/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class DrinkVC: UIViewController {
        
    let weekView = UIView()
    let dateView = UIView()
    var activityView = UIView()
    var statsView = UIView()

    var itemViews: [UIView] = []
    
    var activityVC: ActivityVC!
    var weekActivityVC: WeekActivityVC!

    var daysView: [DWDayView] = []
    
    var swipeUpLabel = DWTitleLabel(textAlignment: .center, fontSize: 15)
    
    var actionButton: ActionButton!
        
    var drunkVolume = 0.0
    var drinkGoal = 300.0
    var percentageGoal = 0.0
        
    var upSwipe: UISwipeGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        configureNavBar()
        layoutUI()
        configureUIElements()
        setupButtons()
    }
    

    func configureNavBar() {
        self.navigationController?.navigationBar.tintColor = UIColor(cgColor: DWColors.greenColor)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .done, target: self, action: #selector(profileButtonTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(profileButtonTapped))
    }
    
    
    @objc func profileButtonTapped() {
        let destVC = UserInfoVC()
        destVC.username = "username"
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
    
    func configureUIElements() {
        
        weekActivityVC = WeekActivityVC()
        self.add(childVC: weekActivityVC, to: self.weekView)
        let dateVC = DateVC()
        self.add(childVC: dateVC, to: self.dateView)
        activityVC = ActivityVC()
        self.add(childVC: activityVC, to: self.activityView)

    }
    
    
    func layoutUI() {
        
        itemViews = [weekView, dateView]
        
        let padding: CGFloat = 20
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
                    
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }
                
        view.addSubview(activityView)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        
        let space1 = UILayoutGuide()
        self.view.addLayoutGuide(space1)
         
        let space2 = UILayoutGuide()
        self.view.addLayoutGuide(space2)
        
        NSLayoutConstraint.activate([
            weekView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            weekView.heightAnchor.constraint(equalToConstant: 50),
            
            dateView.topAnchor.constraint(equalTo: weekView.bottomAnchor, constant: padding),
            
            activityView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width/1.5),
            activityView.heightAnchor.constraint(equalToConstant: self.view.frame.size.width/1.5),
            activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: (navigationController?.navigationBar.frame.size.height)!)
        ])
        
        
        space1.heightAnchor.constraint(equalTo: space2.heightAnchor).isActive = true
        weekView.bottomAnchor.constraint(equalTo: space1.topAnchor).isActive = true
        dateView.topAnchor.constraint(equalTo: space1.bottomAnchor).isActive = true
        dateView.bottomAnchor.constraint(equalTo: space2.topAnchor).isActive = true
        activityView.topAnchor.constraint(equalTo: space2.bottomAnchor, constant: 0).isActive = true

        configureSwipeUpMessage()
    }
    
    
    func configureSwipeUpMessage() {
        view.addSubview(swipeUpLabel)
        swipeUpLabel.text = "Swipe up to see your stats."

        upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeUp))
        upSwipe.direction = .up
        
        view.addGestureRecognizer(upSwipe)
        NSLayoutConstraint.activate([
            swipeUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swipeUpLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
    
    
    @objc func handleSwipeUp() {
        let destVC = StatsVC()
        present(destVC, animated: true)
        
    }
    
    
    func setupButtons() {
        let little = ActionButtonItem(title: "S", image: nil)
        little.action = {item in
            self.drunkVolume += 0.15
            self.animateCircles()
        }
        let average = ActionButtonItem(title: "M", image: nil)
        average.action = {item in
            self.drunkVolume += 0.33
            self.animateCircles()
        }
        let large = ActionButtonItem(title: "L", image: nil)
        large.action = {item in
            self.drunkVolume += 0.75
            self.animateCircles()
        }
        
        actionButton = ActionButton(attachedToView: self.view, items: [little, average, large])
        actionButton.setTitle("+", forState: UIControl.State())
        actionButton.backgroundColor = UIColor(cgColor: DWColors.pastelGreenColor)
        actionButton.action = { button in
            button.toggleMenu()
            
//            if self.percentageGoal >= 1.0 {
////                self.percentageGoal = 1.0
////                self.activityVC.animateCircles(for: self.percentageGoal)
////                self.activityVC.animatePulsatingCircle()
//
//                //self.animateCircles()
//          //      self.activityView.animatePusaltingCircle()
//           //     self.activityView.configureCongratLabel()
//            } else {
//                //button.toggleMenu()
//            }
        }
    }
    
    func animateCircles() {
        percentageGoal = (drunkVolume*100)/drinkGoal
        activityVC.animateCircles(for: percentageGoal)
        if percentageGoal >= 1.0 {
            percentageGoal = 1.0
            activityVC.animateCircles(for: self.percentageGoal)
            activityVC.animatePulsatingCircle()
        }
        weekActivityVC.updateWeekView(with: percentageGoal)
    }
    

    func add(childVC: UIViewController, to containerView: UIView) {
        self.addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}
