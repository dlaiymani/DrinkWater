//
//  DWAgeItemVC.swift
//  DrinkWater
//
//  Created by David Laiymani on 21/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class DWAgeItemVC: UIViewController {
    
    let ageLabel = DWTitleLabel(textAlignment: .left, fontSize: 15)
    let agePicker = UIPickerView()
        
    lazy var pickerData: [Int] = {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: Date())
        var years = [Int]()
        for i in 1900...year { // Attention 2020
            years.append(i)
        }
        return years
    }()
    
    var yob = 1970
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureAgePicker()
        layoutUI()
    }
    
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = UIColor(cgColor: DWColors.lightBlackColor)
    }
    
    private func configureAgePicker() {

        agePicker.delegate = self
        agePicker.dataSource = self
        agePicker.selectRow(70, inComponent: 0, animated: false)

    }
    
    
    private func layoutUI() {
        view.addSubview(ageLabel)
        view.addSubview(agePicker)

        ageLabel.text = "🎂 Year of birth"
        
        let padding: CGFloat = 20
        agePicker.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            ageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            ageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            ageLabel.heightAnchor.constraint(equalToConstant: 20),
            
            agePicker.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 0),
            agePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            agePicker.widthAnchor.constraint(equalToConstant: view.frame.width/2),
            agePicker.heightAnchor.constraint(equalToConstant: 80)
            
        ])
    }
}

extension DWAgeItemVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[row])
    }
    
    
}


extension DWAgeItemVC: UIPickerViewDelegate {
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let color = (row == pickerView.selectedRow(inComponent: component)) ? UIColor(cgColor: DWColors.greenColor) : UIColor.white
        return NSAttributedString(string: String(self.pickerData[row]), attributes: [NSAttributedString.Key.foregroundColor: color])
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadAllComponents()
        yob = pickerData[row]
    }
    
}
