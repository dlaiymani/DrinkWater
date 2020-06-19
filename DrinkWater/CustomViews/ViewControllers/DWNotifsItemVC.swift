//
//  DWNotifsItemVC.swift
//  DrinkWater
//
//  Created by David Laiymani on 27/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class DWNotifsItemVC: UIViewController {
    
    let notifTitleLabel = DWTitleLabel(textAlignment: .left, fontSize: 15)
    let nbNotifsLabel = DWTitleLabel(textAlignment: .left, fontSize: 18)
    let plusButton = DWButton(backgroundColor: DWColors.greenColor, title: "+")
    let minusButton = DWButton(backgroundColor: DWColors.greenColor, title: "-")
    
    let stackView = UIStackView()
    
    private let buttonsSize: CGFloat = 25
    
    var nbNotifs = 3
    var notifStatus = false
    
    var user: User!
    
    init(profile: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = profile
        nbNotifs = user.nbOfNotifs
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(checkNotificationStatus), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        configureBackgroundView()
        configureButtons()
        configureGoalLabel()
        layoutUI()
        configureStackView()
    }
    
    
    @objc private func checkNotificationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case .authorized:
                self.notifStatus = true
            default:
                self.notifStatus = false
                self.nbNotifs = 0
                DispatchQueue.main.async {
                    self.configureGoalLabel()
                }
            }
        }
    }
    
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = UIColor(cgColor: DWColors.lightBlackColor)
    }
    
    
    private func configureButtons() {
        plusButton.set(textColor: DWColors.blackColor)
        minusButton.set(textColor: DWColors.blackColor)
        
        plusButton.set(cornerRadius: buttonsSize/2)
        minusButton.set(cornerRadius: buttonsSize/2)
        
        if !notifStatus {
            nbNotifs = 0
        }
        
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
    }
    
    
    
    @objc private func plusButtonTapped() {
        
        guard notifStatus else {
            presentDWAlertOnMainThread(title: "Notifications are not allowed", message: "Please go  to Settings to change it", buttonTitle: "OK")
            return
        }
        
        switch nbNotifs {
        case 0:
            nbNotifs = 2
        case 2:
            nbNotifs = 3
        case 3:
            nbNotifs = 5
        case 5:
            nbNotifs = 5
        default:
            break
        }
        
        nbNotifsLabel.text = "\(nbNotifs)"
    }
    
    
    @objc private func minusButtonTapped() {
        guard notifStatus else {
            presentDWAlertOnMainThread(title: "Notifications are not allowed", message: "Please go  to Settings to change it", buttonTitle: "OK")
            return
        }
        
        switch nbNotifs {
        case 0:
            nbNotifs = 0
        case 2:
            nbNotifs = 0
        case 3:
            nbNotifs = 2
        case 5:
            nbNotifs = 3
        default:
            break
        }
        nbNotifsLabel.text = "\(nbNotifs)"

    }
    
    
    private func configureGoalLabel() {
        
        nbNotifsLabel.text = "\(nbNotifs)"

    }
    
    
    private func layoutUI() {
        view.addSubview(notifTitleLabel)
       // view.addSubview(plusButton)
        view.addSubview(stackView)

        notifTitleLabel.text = "🔔 Notifications / day"
        
        let padding: CGFloat = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            notifTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            notifTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            notifTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 140),
            stackView.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        NSLayoutConstraint.activate([
            plusButton.widthAnchor.constraint(equalToConstant: buttonsSize),
            plusButton.heightAnchor.constraint(equalToConstant: buttonsSize),
            minusButton.widthAnchor.constraint(equalToConstant: buttonsSize),
            minusButton.heightAnchor.constraint(equalToConstant: buttonsSize),
        ])
        
        stackView.addArrangedSubview(minusButton)
        stackView.addArrangedSubview(nbNotifsLabel)
        stackView.addArrangedSubview(plusButton)
    }
}

