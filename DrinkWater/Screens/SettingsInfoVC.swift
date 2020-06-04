//
//  UserInfoVC.swift
//  GitFollowers
//
//  Created by David Laiymani on 12/04/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

//protocol UserInfoVCDelegate: class {
//    func didTapGitHubProfile(for user: User)
//    func didTapGetFollowers(for user: User)
//}

class SettingsInfoVC: UIViewController {
    
    let itemViewUnits = UIView()
    let itemViewNotifications = UIView()
    let itemViewGlassSizes = UIView()
    var itemViews: [UIView] = []
    
    var unitsItemVC: DWUnitsItemVC!
    var notifsItemVC: DWNotifsItemVC!
    var glassSizeItemVC: DWGlassSizeItemVC!
    
    let stackView = UIStackView()

    let padding: CGFloat = 20
        
    var viewSize: CGFloat = 0
    
    var onBoarding = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        layoutUI()
        configureUIElements()
        configureStackView()
    }
    
    
    func configureViewController() {
        view.backgroundColor = .black
        let doneButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(dismissVC))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = cancelButton
        self.navigationController?.navigationBar.tintColor = UIColor(cgColor: DWColors.greenColor)
        self.navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.title = "Settings"

    }
    
    
    func configureUIElements() {
        
        unitsItemVC = DWUnitsItemVC()
        self.add(childVC: unitsItemVC, to: self.itemViewUnits)
        notifsItemVC = DWNotifsItemVC()
        self.add(childVC: notifsItemVC, to: self.itemViewNotifications)
        glassSizeItemVC = DWGlassSizeItemVC()
        self.add(childVC: glassSizeItemVC, to: self.itemViewGlassSizes)
       
    }
        
    
    func layoutUI() {
        
        itemViews = [itemViewUnits, itemViewNotifications, itemViewGlassSizes]

        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        viewSize = (self.view.frame.height-100)/4
    }

    
    private func configureStackView() {
        
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
           
        stackView.translatesAutoresizingMaskIntoConstraints = false
           
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),

            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        ])
        
        
        if onBoarding {
            let titleLabel = DWUnderlinedLabel(textAlignment: .center, fontSize: 20, text: "Personal Settings")
            
            view.addSubview(titleLabel)
            
            stackView.addArrangedSubview(titleLabel)
        }
        stackView.addArrangedSubview(itemViewUnits)
        stackView.addArrangedSubview(itemViewNotifications)
        stackView.addArrangedSubview(itemViewGlassSizes)
        
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self) //
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
}




