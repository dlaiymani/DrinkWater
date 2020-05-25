//
//  DrinkVC.swift
//  DrinkWater
//
//  Created by David Laiymani on 27/04/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class DrinkVC: UIViewController {
        
    let weekStackView = UIStackView()
    let dateStackView = UIStackView()
    var daysView: [DWWeekView] = []
    let activityStackView = UIStackView()
    var drinkStackView = UIStackView()
    var activityView: DWActivityView!
    var weekView = UIView()
    var statsStackView = UIStackView()
    var myContainerView: UIView!
    
    let pageVC = StatsPageViewController()


    var todayLabel = DWBoldLabel(textAlignment: .left, fontSize: 17)
    var dateLabel = DWTitleLabel(textAlignment: .center, fontSize: 17)
    var activityLevelLabel = DWBoldLabel(textAlignment: .left, fontSize: 15)
    var swipeUpLabel = DWTitleLabel(textAlignment: .center, fontSize: 15)
    var swipeDownLabel = DWTitleLabel(textAlignment: .center, fontSize: 15)
    var statsBoldLabel = DWBoldLabel(textAlignment: .left, fontSize: 17)
    var statsLabel = DWTitleLabel(textAlignment: .center, fontSize: 17)

    
    var actionButton: ActionButton!
    
    var radius = 0.0
    var dayViewHeight: CGFloat = 0.0
    
    var drunkVolume = 0.0
    var drinkGoal = 300.0
    var percentageGoal = 0.0
    
    var goalCompleted = false
    
    var upSwipe: UISwipeGestureRecognizer!
    var downSwipe: UISwipeGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        configureNavBar()
        configureWeekView()
        configureActivityView()
        configureDateLabel()
        setupButtons()
        configureSwipeUpMessage()
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
    
    
    func configureWeekView() {
        weekView = UIView(frame: .zero)
        self.view.addSubview(weekView)
        weekView.translatesAutoresizingMaskIntoConstraints = false
        
        let width = self.view.frame.size.width - 160
        let dayWidth: Int = Int(width/7)
        self.dayViewHeight = CGFloat(dayWidth)
                
        for day in 0...6 {
            let x = CGFloat((dayWidth+20)*day)+20
            let y = CGFloat(0)
            daysView.append(DWWeekView(x: x, y: y, width: CGFloat(dayWidth), height: CGFloat(self.dayViewHeight), percentageCompleted: percentageGoal, dayInInt: day)) 
            weekView.addSubview(daysView[day])
        }
        
        NSLayoutConstraint.activate([
            weekView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            weekView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            weekView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            weekView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    
    func configureActivityView() {
        let width: CGFloat = self.view.frame.size.width/1.5
        let height: CGFloat = width
        
        percentageGoal = (drunkVolume*100)/drinkGoal
        self.radius = Double(width / 2.0)
        
        activityView = DWActivityView(x: self.view.frame.size.width/2 - width/2, y: self.view.frame.size.height/2 - height/2, width: width, height: height, percentageCompleted: percentageGoal)
        
        self.view.addSubview(activityView)
    }
    
    
    func configureDateLabel() {
        view.addSubview(dateStackView)
        
        dateStackView.axis = .horizontal
        dateStackView.distribution = .equalSpacing
        dateStackView.addArrangedSubview(todayLabel)
        dateStackView.addArrangedSubview(dateLabel)
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        
        todayLabel.text = "Today, "
        dateLabel.text = Date().convertToDayMonthYearFormat()
                
        NSLayoutConstraint.activate([
            dateStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        let space1 = UILayoutGuide()
        self.view.addLayoutGuide(space1)
         
        let space2 = UILayoutGuide()
        self.view.addLayoutGuide(space2)
        
        space1.heightAnchor.constraint(equalTo: space2.heightAnchor).isActive = true
        weekView.bottomAnchor.constraint(equalTo: space1.topAnchor).isActive = true
        dateStackView.topAnchor.constraint(equalTo: space1.bottomAnchor).isActive = true
        dateStackView.bottomAnchor.constraint(equalTo: space2.topAnchor).isActive = true
        activityView.topAnchor.constraint(equalTo: space2.bottomAnchor, constant: 15).isActive = true
    }
    
    
    private func updateWeekView() {
        for day in 0...6 {
            daysView[day].drawActivityCircle(percentage: percentageGoal)
        }
    }
    
    
    private func animateCircles() {
        percentageGoal = (drunkVolume*100)/drinkGoal
        if percentageGoal >= 1.0 {
            percentageGoal = 1.0
            goalCompleted = true
            self.actionButton.disableActionButton()
            self.activityView.animatePusaltingCircle()
        }
        activityView.animateActivityLabel(percentage: percentageGoal)
        activityView.updateActivityCircle(percentage: percentageGoal)
        updateWeekView()
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
            if self.percentageGoal >= 1.0 {
                self.percentageGoal = 1.0
                self.animateCircles()
                self.activityView.animatePusaltingCircle()
                self.activityView.configureCongratLabel()
            } else {
                button.toggleMenu()
            }
        }
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
    
    
    func configureStatsVC() {
        myContainerView = UIView()
        myContainerView.translatesAutoresizingMaskIntoConstraints = false
        myContainerView.backgroundColor = .black
          
        view.addSubview(myContainerView)
        
        NSLayoutConstraint.activate([
            myContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            myContainerView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            myContainerView.heightAnchor.constraint(equalToConstant: view.frame.size.height)
            ])
        
        addChild(pageVC)
        configureSwipeDownMessage()
      //  configureStatsLabel()
        configureSwipeDownGesture()
    }
        
       
    
    @objc func handleSwipeUp() {
        configureStatsVC()
        myContainerView.backgroundColor = .black
        UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                   self.view.addSubview(self.pageVC.view)
                   self.navigationController?.navigationBar.isHidden = true
               }, completion: { (Bool) in
                DWChartsView.playAnimations()

                self.swipeDownLabel.isHidden = false
                self.statsBoldLabel.isHidden = false
                self.statsLabel.isHidden = false
                self.view.addGestureRecognizer(self.downSwipe)
                self.view.removeGestureRecognizer(self.upSwipe)
        })
           
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
               
        NSLayoutConstraint.activate([
            pageVC.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageVC.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pageVC.view.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.2),
            pageVC.view.heightAnchor.constraint(equalToConstant: view.frame.size.height/1.5)
        ])

        myContainerView.addSubview(pageVC.view)
            
        pageVC.didMove(toParent: self)
    }
    
    
    private func configureSwipeDownMessage() {
        myContainerView.addSubview(swipeDownLabel)
        swipeDownLabel.text = "Swipe down to drink."
        NSLayoutConstraint.activate([
            swipeDownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swipeDownLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
        swipeDownLabel.isHidden = true
    }
    
    
    private func configureStatsLabel() {
        myContainerView.addSubview(statsStackView)
           
        statsBoldLabel.text = "Week "
        statsLabel.text = "achievements"
        
        statsStackView.axis = .horizontal
        statsStackView.distribution = .equalSpacing
        statsStackView.addArrangedSubview(statsBoldLabel)
        statsStackView.addArrangedSubview(statsLabel)
        statsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 40)
        ])
        statsLabel.isHidden = true
        statsBoldLabel.isHidden = true
    }
    
    
    private func configureSwipeDownGesture() {
        downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown))
        downSwipe.direction = .down
    }
    
    
    @objc func handleSwipeDown() {
        UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromTop, animations: {
            self.myContainerView.removeFromSuperview()
            self.navigationController?.navigationBar.isHidden = false
            self.view.removeGestureRecognizer(self.downSwipe)
            self.view.addGestureRecognizer(self.upSwipe)

        }, completion: { (Bool) in
            let weekVC = self.pageVC.pages[0] as! WeekStatsVC2
           // weekVC.statsView.removeFromSuperview()
        })
    }
}
