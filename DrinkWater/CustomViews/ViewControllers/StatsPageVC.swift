//
//  StatsPageViewController.swift
//  DrinkWater
//
//  Created by David Laiymani on 15/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class StatsPageVC: UIPageViewController {
    
    var pages: [UIViewController] = [UIViewController]()
    let weekVC = WeekStatsVC2()
    let yearVC = YearStatsVC()
    
    var statsView = UIView()

    

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
           super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
           delegate = nil

        configureBackgroundView()
        
       // weekVC = WeekStatsVC2()
        pages.append(weekVC)
      //  yearVC = YearStatsVC()
        pages.append(yearVC)

        setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
                
       // layoutUI()
//
    }
    
    
    private func configureBackgroundView() {
        view.backgroundColor = .black

    }
    
    
    private func layoutUI() {
       // view.addSubview(statsView)
        view.translatesAutoresizingMaskIntoConstraints = false
        print(view.frame.size.width)
        
        NSLayoutConstraint.activate([
        //    view.centerXAnchor.constraint(equalTo: view.superview!.centerXAnchor),
        //    view.centerYAnchor.constraint(equalTo: view.superview!.centerYAnchor),
            view.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.2),
            view.heightAnchor.constraint(equalToConstant: view.frame.size.height/1.5)
        ])
        
        view.layoutIfNeeded()
        
    }
    
    
    
}

extension StatsPageVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else { return pages.last }

        guard pages.count > previousIndex else { return nil }

        return pages[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }

        let nextIndex = viewControllerIndex + 1

        guard nextIndex < pages.count else { return pages.first }

        guard pages.count > nextIndex else { return nil }

        return pages[nextIndex]
    }
}


extension StatsPageVC: UIPageViewControllerDelegate {

    // if you do NOT want the built-in PageControl (the "dots"), comment-out these funcs

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {

        guard let firstVC = pageViewController.viewControllers?.first else {
            return 0
        }
        guard let firstVCIndex = pages.firstIndex(of: firstVC) else {
            return 0
        }

        return firstVCIndex
    }
}
