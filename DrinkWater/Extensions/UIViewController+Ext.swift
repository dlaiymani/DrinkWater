//
//  UIViewController+Ext.swift
//  DrinkWater
//
//  Created by David Laiymani on 02/06/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit


extension UIViewController {

    func presentDWAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = DWAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
