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
    let pageVC = StatsPageVC()

    var daysView: [DWDayView] = []
    
    var activityLevelLabel = DWBoldLabel(textAlignment: .left, fontSize: 15)
    var swipeUpLabel = DWTitleLabel(textAlignment: .center, fontSize: 15)
    var swipeDownLabel = DWTitleLabel(textAlignment: .center, fontSize: 15)
    var statsBoldLabel = DWBoldLabel(textAlignment: .left, fontSize: 17)
    var statsLabel = DWTitleLabel(textAlignment: .center, fontSize: 17)

    
    var actionButton: ActionButton!
        
    var drunkVolume = 0.0
    var drinkGoal = 300.0
    var percentageGoal = 0.0
        
    var upSwipe: UISwipeGestureRecognizer!
   // var downSwipe: UISwipeGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        configureNavBar()
        layoutUI()
        configureUIElements()
        setupButtons()

      //  configureWeekView()
//        configureActivityView()
//        configureDateLabel()
//        setupButtons()
//        configureSwipeUpMessage()
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
        
//        view.addSubview(statsView)
//        statsView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            statsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            statsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            statsView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
//            statsView.heightAnchor.constraint(equalToConstant: view.frame.size.height)
//            ])
        
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
        //let navController = UINavigationController(rootViewController: destVC)
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
    
    
    
    func configureStatsVC() {
        
        addChild(pageVC)
//        configureSwipeDownMessage()
//        configureSwipeDownGesture()
    }
    
    
    
    
//    @objc func handleSwipeUp() {
//
//        addChild(pageVC)
//        configureSwipeDownMessage()
//       // configureSwipeDownGesture()
//        //configureStatsVC()
//       // statsView.backgroundColor = .black
//        UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromBottom, animations: {
//            self.view.addSubview(self.pageVC.view)
//            self.navigationController?.navigationBar.isHidden = true
//        }, completion: { (Bool) in
//            DWChartsView.playAnimations()
//
//            self.swipeDownLabel.isHidden = false
//            self.statsBoldLabel.isHidden = false
//            self.statsLabel.isHidden = false
//            self.view.addGestureRecognizer(self.downSwipe)
//            self.view.removeGestureRecognizer(self.upSwipe)
//        })
//
//        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
//        statsView.addSubview(pageVC.view)
//
//        NSLayoutConstraint.activate([
//            pageVC.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            pageVC.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            pageVC.view.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.2),
//            pageVC.view.heightAnchor.constraint(equalToConstant: view.frame.size.height/1.5)
//        ])
//
//
//        pageVC.didMove(toParent: self)
//    }
       
    
    
//    private func configureSwipeDownMessage() {
//        statsView.addSubview(swipeDownLabel)
//        swipeDownLabel.text = "Swipe down to drink."
//        NSLayoutConstraint.activate([
//            swipeDownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            swipeDownLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
//        ])
//        swipeDownLabel.isHidden = true
//    }
    
    
    
//    private func configureSwipeDownGesture() {
//        downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown))
//        downSwipe.direction = .down
//    }
    
    
//    @objc func handleSwipeDown() {
//        UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromTop, animations: {
//         //   self.statsView.removeFromSuperview()
//            self.pageVC.removeFromParent()
//            self.navigationController?.navigationBar.isHidden = false
//            self.view.removeGestureRecognizer(self.downSwipe)
//            self.view.addGestureRecognizer(self.upSwipe)
//
//        }, completion: { (Bool) in
//            let weekVC = self.pageVC.pages[0] as! WeekStatsVC2
//           // weekVC.statsView.removeFromSuperview()
//        })
//    }
   
    
    func add(childVC: UIViewController, to containerView: UIView) {
        self.addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
//    func configureWeekView() {
//        weekView = UIView(frame: .zero)
//        self.view.addSubview(weekView)
//        weekView.translatesAutoresizingMaskIntoConstraints = false
//
//        let width = self.view.frame.size.width - 160
//        let dayWidth: Int = Int(width/7)
//        self.dayViewHeight = CGFloat(dayWidth)
//
//        for day in 0...6 {
//            let x = CGFloat((dayWidth+20)*day)+20
//            let y = CGFloat(0)
//            daysView.append(DWDayView(x: x, y: y, width: CGFloat(dayWidth), height: CGFloat(self.dayViewHeight), percentageCompleted: percentageGoal, dayInInt: day))
//            weekView.addSubview(daysView[day])
//        }
//
//        NSLayoutConstraint.activate([
//            weekView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            weekView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            weekView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
//            weekView.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
    
    
    
//    func configureActivityView() {
//        let width: CGFloat = self.view.frame.size.width/1.5
//        let height: CGFloat = width
//
//        percentageGoal = (drunkVolume*100)/drinkGoal
//        self.radius = Double(width / 2.0)
//
//        activityView = DWActivityView(x: self.view.frame.size.width/2 - width/2, y: self.view.frame.size.height/2 - height/2, width: width, height: height, percentageCompleted: percentageGoal)
//
//        self.view.addSubview(activityView)
//    }
    
    
//    func configureDateLabel() {
//        view.addSubview(dateStackView)
//
//        dateStackView.axis = .horizontal
//        dateStackView.distribution = .equalSpacing
//        dateStackView.addArrangedSubview(todayLabel)
//        dateStackView.addArrangedSubview(dateLabel)
//        dateStackView.translatesAutoresizingMaskIntoConstraints = false
//
//        todayLabel.text = "Today, "
//        dateLabel.text = Date().convertToDayMonthYearFormat()
//
//        NSLayoutConstraint.activate([
//            dateStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//        ])
//
//        let space1 = UILayoutGuide()
//        self.view.addLayoutGuide(space1)
//
//        let space2 = UILayoutGuide()
//        self.view.addLayoutGuide(space2)
//
//        space1.heightAnchor.constraint(equalTo: space2.heightAnchor).isActive = true
//        weekView.bottomAnchor.constraint(equalTo: space1.topAnchor).isActive = true
//        dateStackView.topAnchor.constraint(equalTo: space1.bottomAnchor).isActive = true
//        dateStackView.bottomAnchor.constraint(equalTo: space2.topAnchor).isActive = true
//        activityView.topAnchor.constraint(equalTo: space2.bottomAnchor, constant: 15).isActive = true
//    }
    
    
//    private func updateWeekView() {
//        for day in 0...6 {
//            daysView[day].drawActivityCircle(day: day, percentage: percentageGoal)
//        }
//    }
    
    
//    private func animateCircles() {
//        percentageGoal = (drunkVolume*100)/drinkGoal
//        if percentageGoal >= 1.0 {
//            percentageGoal = 1.0
//            goalCompleted = true
//            self.actionButton.disableActionButton()
//        //    self.activityView.animatePusaltingCircle()
//        }
//      //  activityView.animateActivityLabel(percentage: percentageGoal)
//     //   activityView.updateActivityCircle(percentage: percentageGoal)
//        updateWeekView()
//    }
    
    
    
    
    
    
   
    
//    private func configureSwipeDownMessage() {
//        statsView.addSubview(swipeDownLabel)
//        swipeDownLabel.text = "Swipe down to drink."
//        NSLayoutConstraint.activate([
//            swipeDownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            swipeDownLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
//        ])
//        swipeDownLabel.isHidden = true
//    }
//
//
//
//    private func configureSwipeDownGesture() {
//        downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown))
//        downSwipe.direction = .down
//    }
//
//
//    @objc func handleSwipeDown() {
//        UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromTop, animations: {
//            self.statsView.removeFromSuperview()
//            self.navigationController?.navigationBar.isHidden = false
//            self.view.removeGestureRecognizer(self.downSwipe)
//            self.view.addGestureRecognizer(self.upSwipe)
//
//        }, completion: { (Bool) in
//            let weekVC = self.pageVC.pages[0] as! WeekStatsVC2
//           // weekVC.statsView.removeFromSuperview()
//        })
//    }
}
