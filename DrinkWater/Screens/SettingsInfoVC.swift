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
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !onBoarding {
            getExistingProfile()
        } else {
            self.user = User(yob: 1980, weight: 70, sex: "F", preferredDrinkSize: PreferedSizes(prefArray: [.s, .m, .xl]), dailyGoal: 1200, units: .cl, nbOfNotifs: 3)
        }
        configureViewController()
        layoutUI()
        configureUIElements()
        configureStackView()
    }
    
    
    func getExistingProfile() {
            PersistenceManager.retreiveProfile { (result) in
                switch result {
                case .success(let profile):
                    self.user = profile
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func configureViewController() {
        view.backgroundColor = .black
        let doneButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveProfile))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = cancelButton
        self.navigationController?.navigationBar.tintColor = UIColor(cgColor: DWColors.greenColor)
        self.navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.title = "Settings"

    }
    
    
    func configureUIElements() {
        
        unitsItemVC = DWUnitsItemVC(profile: user)
        self.add(childVC: unitsItemVC, to: self.itemViewUnits)
        notifsItemVC = DWNotifsItemVC(profile: user)
        self.add(childVC: notifsItemVC, to: self.itemViewNotifications)
        glassSizeItemVC = DWGlassSizeItemVC(profile: user)
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
    
    
    
    @objc func saveProfile() {
        
        let glassSizes = glassSizeItemVC.user.preferredDrinkSize
        
        guard !glassSizes.prefArray.isEmpty  else {
            //presentDWAlertOnMainThread(title: "No Prefered Glass Size Selected", message: "Please select one at least", buttonTitle: "OK")
            let alertVC = DWAlertVC(title: "No Glass Size Selected", message: "Please select one at least", buttonTitle: "OK")
            present(alertVC, animated: true, completion: nil)
            return
        }
        
        user = User(yob: user.yob , weight: Double(user.weight), sex: user.sex, preferredDrinkSize: glassSizes, dailyGoal: Double(user.dailyGoal), units: unitsItemVC.unit, nbOfNotifs: notifsItemVC.nbNotifs)
        
        PersistenceManager.updateWith(profile: user) { [weak self] (error) in
            guard let self = self else { return }
            guard let error = error else { return }
            print(error.rawValue)
        }
        
        dismiss(animated: true)
    }
}




