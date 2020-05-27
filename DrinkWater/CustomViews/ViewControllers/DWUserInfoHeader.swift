//
//  DWUserInfoHeader.swift
//  DrinkWater
//
//  Created by David Laiymani on 20/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//
import UIKit

class DWUserInfoHeaderVC: UIViewController {
    
    let usernameLabel = DWBoldLabel(textAlignment: .left, fontSize: 24)
    let nameLabel = DWTitleLabel(textAlignment: .left, fontSize: 16)
    let locationImageView = UIImageView()
    let locationLabel = DWTitleLabel(textAlignment: .left, fontSize: 16)
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addSubViews()
        layoutUI()
        configureUIElements()
    }
    
    func configureUIElements() {
        usernameLabel.text = user.username
        nameLabel.text = user.name ?? ""
        
        usernameLabel.tintColor = .white
        
        locationLabel.text = user.location ?? "No location"
        locationImageView.image = UIImage(systemName: "mappin.and.ellipse")
        locationImageView.tintColor = UIColor(cgColor: DWColors.greenColor)
    }
    
    
    func addSubViews() {
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            locationImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            
            locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
           // locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
//            
//            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagepadding),
//            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
//            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    

    
}
