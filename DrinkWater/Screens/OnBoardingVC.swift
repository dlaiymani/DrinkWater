//
//  OnBoardingVC.swift
//  DrinkWater
//
//  Created by David Laiymani on 02/06/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class OnBoardingVC: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UNUserNotificationCenterDelegate {
    var pageController: UIPageViewController!
    var controllers = [UIViewController]()
    
    let profileVC = UserInfoVC()
    let settingsVC = SettingsInfoVC()
    
    let notifCenter = UNUserNotificationCenter.current()

    

    override func viewDidLoad() {
        super.viewDidLoad()

        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController.dataSource = self
        pageController.delegate = self

        
        addChild(pageController)
        view.addSubview(pageController.view)

        let views = ["pageController": pageController.view] as [String: AnyObject]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[pageController]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[pageController]|", options: [], metrics: nil, views: views))
        
        let welcomeVC = DWAlertVC(title: "Welcome to DrinkWater", message: "Let's get to know each other", buttonTitle: "Logo")
        controllers.append(welcomeVC)
        
        profileVC.onBoarding = true
        controllers.append(profileVC)
        settingsVC.onBoarding = true
        controllers.append(settingsVC)
        let endVC = DWAlertVC(title: "Everything's fine", message: "Let's hydrate now!", buttonTitle: "Start Now")
        controllers.append(endVC)
        endVC.actionButton.addTarget(self, action: #selector(saveAndStart), for: .touchUpInside)

        pageController.setViewControllers([controllers[0]], direction: .forward, animated: true)
    }
    
    
    
    @objc func saveAndStart() {
        saveProfile()
        
        let mainVC = DrinkVC()
        self.navigationController?.pushViewController(mainVC, animated: true)

//        UIView.transition(from: (UIApplication.shared.windows.first?.rootViewController!.view)!, to: navigationController.view, duration: 0.6, options: [.transitionFlipFromRight], completion: {
//            _ in
//        })
    }

    
    
    func saveProfile() {
        
        let glassSizes = settingsVC.user.preferredDrinkSize
        
        
        let user = User(yob: profileVC.ageItemVC.yob, weight: Double(profileVC.weightItemVC.weight), sex: profileVC.sexItemVC.sex, preferredDrinkSize: glassSizes, dailyGoal: Double(profileVC.goalItemVC.goal), units: settingsVC.unitsItemVC.unit, nbOfNotifs: settingsVC.notifsItemVC.nbNotifs)
        
        scheduleLocalNotification()
        
        PersistenceManager.updateWith(profile: user) { [weak self] (error) in
            guard let self = self else { return }
            guard let error = error else { return }
            print(error.rawValue)
        }
    }
    
    
    func scheduleLocalNotification() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Remember to hydrate"
        content.body = ""
        content.sound = UNNotificationSound.default
        
        var scheduleHours = [(Int, Int)]()

        switch settingsVC.notifsItemVC.nbNotifs {
        case 2:
            scheduleHours = [(12, 0), (18, 0)]
        case 3:
            scheduleHours = [(9, 0), (12, 0), (18, 0)]
        case 5:
            scheduleHours = [(9, 0), (10, 30), (12, 0), (15, 30), (18, 0)]
        default:
            break
        }
        
        for hour in scheduleHours {
            var dateComponents = DateComponents()
            dateComponents.hour = hour.0
            dateComponents.minute = hour.1
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)


            let request = UNNotificationRequest.init(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            center.add(request)
        }
    }

    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController) {
            if index > 0 {
                return controllers[index - 1]
            } else {
                return nil
            }
        }

        return nil
    }
    


    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController) {
            if index < controllers.count - 1 {
                return controllers[index+1]
            } else {
                return nil
            }
        }

        return nil
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        setupPageControl()
        return controllers.count
    }

    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.darkGray
        appearance.currentPageIndicatorTintColor = UIColor(cgColor: DWColors.greenColor)
        appearance.backgroundColor = UIColor.black
    }
    

    func randomCGFloat() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }

    func randomColor() -> UIColor {
        return UIColor(red: randomCGFloat(), green: randomCGFloat(), blue: randomCGFloat(), alpha: 1)
    }
}
