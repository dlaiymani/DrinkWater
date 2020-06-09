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
    
    var user: User!
    
    var userNavController: UINavigationController!
    var settingsNavController: UINavigationController!
    let userInfoVC = UserInfoVC()
    let settingsInfoVC = SettingsInfoVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        configureVC()
        configureNavBar()
        layoutUI()
        configureUIElements()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let actionButton = actionButton {
            if actionButton.active {
                actionButton.toggleMenu()
            }
        }
        getUserProfile()
        setupButtons()
    }
    
    
    func configureVC() {
        let destVC = UserInfoVC()
        userNavController = UINavigationController(rootViewController: destVC)
        userNavController.modalPresentationStyle = .fullScreen
        
        let destSetVC = SettingsInfoVC()
        settingsNavController = UINavigationController(rootViewController: destSetVC)
        settingsNavController.modalPresentationStyle = .fullScreen
    }
    
    
    
    func getUserProfile() {
        PersistenceManager.retreiveProfile { (result) in
            switch result {
            case .success(let existingProfile):
                guard let existingProfile = existingProfile else {
                    self.user = User(yob: 1980, weight: 70, sex: "F", preferredDrinkSize: PreferedSizes(prefArray: [.s, .m, .xl]), dailyGoal: 1200, units: .cl, nbOfNotifs: 3)
                    return
                }
                self.user = existingProfile
                self.drinkGoal = existingProfile.dailyGoal
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    

    func configureNavBar() {
        self.navigationController?.navigationBar.tintColor = UIColor(cgColor: DWColors.greenColor)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .done, target: self, action: #selector(profileButtonTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(settingsButtonTapped))
    }
    
    
    @objc func profileButtonTapped() {
       
        if actionButton.active {
            actionButton!.toggleMenu()
        }
        present(userNavController, animated: true)
    }
    
    
    @objc func settingsButtonTapped() {

        if actionButton.active {
            actionButton!.toggleMenu()
        }

        present(settingsNavController, animated: true)
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
        
        var items = [ActionButtonItem]()
        
        let prefSizes = user.preferredDrinkSize.convertFrom(unit: user.units)
        
        for s in prefSizes.sorted() {
            let button = ActionButtonItem(title: "\(s)", image: nil)
            items.append(button)
            button.action = {item in
                self.drunkVolume += Double(s)
                self.animateCircles()
            }
        }
        
        if let actionButton = actionButton {
            actionButton.items = items
            
        } else {
            actionButton = ActionButton(attachedToView: self.view, items: items)
        }
        
        actionButton.setTitle("+", forState: UIControl.State())
        actionButton.backgroundColor = UIColor(cgColor: DWColors.pastelGreenColor)
        actionButton.action = { button in
            if self.percentageGoal >= 1.0 {
                self.percentageGoal = 1.0
            } else {
                button.toggleMenu()
            }
        }
    }
    
    
    func animateCircles() {
        percentageGoal = (drunkVolume)/drinkGoal
        activityVC.animateCircles(for: percentageGoal)
        if percentageGoal >= 1.0 {
            percentageGoal = 1.0
            actionButton.toggleMenu()
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
