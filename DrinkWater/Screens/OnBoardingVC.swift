//
//  OnBoardingVC.swift
//  DrinkWater
//
//  Created by David Laiymani on 02/06/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class OnBoardingVC: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var pageController: UIPageViewController!
    var controllers = [UIViewController]()

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
        let profileVC = UserInfoVC()
        profileVC.onBoarding = true
        controllers.append(profileVC)
        let settingsVC = SettingsInfoVC()
        settingsVC.onBoarding = true
        controllers.append(settingsVC)

        pageController.setViewControllers([controllers[0]], direction: .forward, animated: true)
    }

    
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        print("yop")
//
//
//    }
    
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
            print(index)
            if index < controllers.count - 1 {
                return controllers[index+1]
            } else {
                print("ya")
                dismiss(animated: true, completion: nil)
                let destVC = DrinkVC()
                let navController = UINavigationController(rootViewController: destVC)
                navController.navigationBar.barTintColor = .black

                UIView.transition(from: (UIApplication.shared.windows.first?.rootViewController!.view)!, to: navController.view, duration: 0.6, options: [.transitionFlipFromRight], completion: {
                    _ in
//                    UIApplication.shared.windows.first?.rootViewController = navController
//                    UIApplication.shared.windows.first?.makeKeyAndVisible()

                })

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
