//
//  DWWeightItemVC.swift
//  DrinkWater
//
//  Created by David Laiymani on 22/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit

class DWWeightItemVC: UIViewController {
    
    let weightLabel = DWTitleLabel(textAlignment: .left, fontSize: 15)
    let weightPicker = UIPickerView()
    let unitLabel = DWTitleLabel(textAlignment: .left, fontSize: 15)
    
    var weight = 70.0
    var user: User!
        
    lazy var pickerData: [Int] = {
        var weights = [Int]()
        for i in 0...200 {
            weights.append(i)
        }
        return weights
    }()
    
    lazy var pickerUnits: [String] = {
        return ["kg", "lb"]
    }()
    
    
    init(profile: User) {
        super.init(nibName: nil, bundle: nil)
        user = profile
        weight = user.weight
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

        weightPicker.delegate = self
        weightPicker.dataSource = self
        weightPicker.selectRow(Int(weight), inComponent: 0, animated: false)
        weightPicker.selectRow(0, inComponent: 1, animated: false)


    }
    
    
    private func layoutUI() {
        view.addSubview(weightLabel)
        view.addSubview(weightPicker)
       // view.addSubview(unitLabel)

        weightLabel.text = "⏲ Weight"
        unitLabel.text = "kg"
        
        let padding: CGFloat = 20
        weightPicker.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            weightLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            weightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            weightLabel.heightAnchor.constraint(equalToConstant: 20),
            
           // weightPicker.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 0),
            weightPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weightPicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            weightPicker.widthAnchor.constraint(equalToConstant: 100),
            weightPicker.heightAnchor.constraint(equalToConstant: 80),
            
//            unitLabel.centerYAnchor.constraint(equalTo: weightPicker.centerYAnchor),
//            unitLabel.leadingAnchor.constraint(equalTo: weightPicker.trailingAnchor, constant: 0),
//            unitLabel.heightAnchor.constraint(equalToConstant: 20),

        ])
    }
}

extension DWWeightItemVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return pickerData.count
        } else {
            return pickerUnits.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return String(pickerData[row])
        } else {
            return pickerUnits[row]
        }
    }
    
    
}


extension DWWeightItemVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let color = (row == pickerView.selectedRow(inComponent: component)) ? UIColor(cgColor: DWColors.greenColor) : UIColor.white
        if component == 0 {
            return NSAttributedString(string: String(self.pickerData[row]), attributes: [NSAttributedString.Key.foregroundColor: color])
        } else {
            return NSAttributedString(string: String(self.pickerUnits[row]), attributes: [NSAttributedString.Key.foregroundColor: color])
        }
        
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadAllComponents()
        weight = Double(pickerData[row])
    }
    
}
