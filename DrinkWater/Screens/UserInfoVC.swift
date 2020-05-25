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
    
    let stackView = UIStackView()

    let padding: CGFloat = 20
    
    var username: String!
    
    var viewSize: CGFloat = 0
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = User(username: username, name: "David Mclem", location: nil, age: 25, weight: 80, height: 180, sport: true, sex: "M", preferredDrinkSize: [25, 50, 75], createdAt: "20/05/2020")

        configureViewController()
        layoutUI()
        configureUIElements(with: user!)
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
       // self.navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.title = "Profil"

    }
    
    
    func configureUIElements(with user: User) {
        
        let sexItemVC = DWSexItemVC(user: user)
        self.add(childVC: sexItemVC, to: self.itemViewSex)
        let ageItemVC = DWAgeItemVC(user: user)
        self.add(childVC: ageItemVC, to: self.itemViewAge)
        let weightItemVC = DWWeightItemVC(user: user)
        self.add(childVC: weightItemVC, to: self.itemViewWeight)
        let goalItemVC = DWGoalItemVC(user: user)
        self.add(childVC: goalItemVC, to: self.itemViewGoal)
    }
        
    
    func layoutUI() {
        
        itemViews = [itemViewSex, itemViewAge, itemViewWeight, itemViewGoal]

                
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
//            NSLayoutConstraint.activate([
//                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
//                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
//            ])
        }
        
        viewSize = (self.view.frame.height-100)/4
      // viewSize = 150
        
        NSLayoutConstraint.activate([
        //    itemViewSex.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
          //  itemViewSex.heightAnchor.constraint(equalToConstant: viewSize),
          //  itemViewAge.topAnchor.constraint(equalTo: itemViewSex.bottomAnchor, constant: padding),
      //      itemViewAge.heightAnchor.constraint(equalToConstant: viewSize),
         //   itemViewWeight.topAnchor.constraint(equalTo: itemViewAge.bottomAnchor, constant: padding),
      //      itemViewWeight.heightAnchor.constraint(equalToConstant: viewSize),
         //   itemViewGoal.topAnchor.constraint(equalTo: itemViewWeight.bottomAnchor, constant: padding),
      //      itemViewGoal.heightAnchor.constraint(equalToConstant: viewSize),
           
        ])
    }

    
    private func configureStackView() {
        
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
           
        stackView.translatesAutoresizingMaskIntoConstraints = false
           
        
        
        NSLayoutConstraint.activate([
            //stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         //   stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
       //     stackView.heightAnchor.constraint(equalToConstant: viewSize*4+60)
        
        ])
        
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
    
}



