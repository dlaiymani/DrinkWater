//
//  SceneDelegate.swift
//  DrinkWater
//
//  Created by David Laiymani on 27/04/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
                
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let alwaysFirstLaunch = FirstLaunch.alwaysFirst()
        if !alwaysFirstLaunch.isFirstLaunch {
            window?.rootViewController = createOnBoardingVC()
            window?.makeKeyAndVisible()
        } else {
            window?.rootViewController = createNavVC()
            window?.makeKeyAndVisible()
        }
    }
    
    
    func createOnBoardingVC() -> UIViewController {
        let onboardingVC = OnBoardingVC()
        return onboardingVC
    }
    
    
    func createUserInfoVC() -> UINavigationController {
        let destVC = UserInfoVC()
        let navController = UINavigationController(rootViewController: destVC)
        
        return navController
        
    }
    
    func createAlertVC() -> UIViewController {
        let alertVC = DWAlertVC(title: "Welcome to DrinkWater", message: "Let's get to know each other", buttonTitle: "Next")
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        
        return alertVC
        
    }
    
    func createNavVC() -> UINavigationController {
        let drinkVC = DrinkVC()
        let navVC = UINavigationController(rootViewController: drinkVC)
        navVC.navigationBar.barTintColor = .black
    //    navVC.navigationBar.tintColor = .systemBlue
   //     navVC.title = "toto"
     //   navVC.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        
        return navVC
    }
    
    func createDrinkViewController() -> UIViewController {
        let drinkVC = DrinkVC()
                
        drinkVC.tabBarItem = UITabBarItem(title: "Drink", image: UIImage(named: "bottle"), tag:0)
        return drinkVC
    }
    
//    func createStatsViewController() -> UIViewController {
//        let statsVC = WeekStatsVC()
//        statsVC.tabBarItem = UITabBarItem(title: "Progress", image: UIImage(systemName: "chart.bar"), tag: 1)
//        return statsVC
//    }
    
//    func createProfileViewController() -> UIViewController {
//        let profileVC = ProfileVC()
//        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
//        
//        return profileVC
//    }
    
//    func createTabbar() -> UITabBarController {
//        let drinkVC = createDrinkViewController()
//        let statsVC = createStatsViewController()
//        let profileVC = createProfileViewController()
//        
//        let tabbar = UITabBarController()
//        tabbar.viewControllers = [drinkVC, statsVC, profileVC]
//        
//        return tabbar
//    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

