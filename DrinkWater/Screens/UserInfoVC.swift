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

class UserInfoVC: UIViewController {
    
    let itemViewSex = UIView()
    let itemViewAge = UIView()
    let itemViewWeight = UIView()
    let itemViewGoal = UIView()
    var itemViews: [UIView] = []
    
    var sexItemVC: DWSexItemVC!
    var ageItemVC: DWAgeItemVC!
    var weightItemVC: DWWeightItemVC!
    var goalItemVC: DWGoalItemVC!
    
    let stackView = UIStackView()

    let padding: CGFloat = 20
    
    var username: String!
    
    var viewSize: CGFloat = 0
    
    var user: User?
    
    var onBoarding = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !onBoarding {
            getExistingProfile()
        } else {
            self.user = User(yob: 1980, weight: 70, sex: "F", preferredDrinkSize: PreferedSizes(prefArray: [.s, .m, .xl]), dailyGoal: 200, units: .cl, nbOfNotifs: 3)
        }

        configureViewController()
        layoutUI()
        configureUIElements(with: user!)
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
        self.title = "Profil"

    }
    
    
    func configureUIElements(with user: User) {
        
        sexItemVC = DWSexItemVC(profile: user)
        self.add(childVC: sexItemVC, to: self.itemViewSex)
        ageItemVC = DWAgeItemVC(profile: user)
        self.add(childVC: ageItemVC, to: self.itemViewAge)
        weightItemVC = DWWeightItemVC(profile: user)
        self.add(childVC: weightItemVC, to: self.itemViewWeight)
        goalItemVC = DWGoalItemVC(profile: user)
        self.add(childVC: goalItemVC, to: self.itemViewGoal)
    }
        
    
    func layoutUI() {
        
        itemViews = [itemViewSex, itemViewAge, itemViewWeight, itemViewGoal]
                
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        viewSize = (self.view.frame.height-100)/4

    }

    
    private func configureStackView() {
        
        view.addSubview(stackView)
        stackView.axis          = .vertical
        stackView.distribution  = .fillEqually
        stackView.spacing       = 20
           
        stackView.translatesAutoresizingMaskIntoConstraints = false
           
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),        
        ])
        
        if onBoarding {
            let titleLabel = DWUnderlinedLabel(textAlignment: .center, fontSize: 20, text: "Personal Information")
            
            view.addSubview(titleLabel)
            stackView.addArrangedSubview(titleLabel)
        }
        
        stackView.addArrangedSubview(itemViewSex)
        stackView.addArrangedSubview(itemViewAge)
        stackView.addArrangedSubview(itemViewWeight)
        stackView.addArrangedSubview(itemViewGoal)

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
                
        user = User(yob: ageItemVC.yob, weight: Double(weightItemVC.weight), sex: sexItemVC.sex, preferredDrinkSize: user!.preferredDrinkSize, dailyGoal: Double(goalItemVC.goal), units: goalItemVC.units, nbOfNotifs: user!.nbOfNotifs)
        
        PersistenceManager.updateWith(profile: user!) { [weak self] (error) in
            guard let self = self else { return }
            guard let error = error else { return }
            print(error.rawValue)
        }
        
        dismiss(animated: true)
    }
}



