//
//  DWGlassSizeItemVC.swift
//  DrinkWater
//
//  Created by David Laiymani on 27/05/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//


import UIKit

class DWGlassSizeItemVC: UIViewController {
    
    let glassSizeLabel = DWTitleLabel(textAlignment: .left, fontSize: 15)
    let sButton = DWButton(backgroundColor: DWColors.greenColor, title: "\(DWGlassSizes.s.rawValue) cl")
    let mButton = DWButton(backgroundColor: DWColors.whiteColor, title: "\(DWGlassSizes.m.rawValue) cl")
    let lButton = DWButton(backgroundColor: DWColors.greenColor, title: "\(DWGlassSizes.l.rawValue) cl")
    let xlButton = DWButton(backgroundColor: DWColors.whiteColor, title: "\(DWGlassSizes.xl.rawValue) cl")
    let xxlButton = DWButton(backgroundColor: DWColors.greenColor, title: "\(DWGlassSizes.xxl.rawValue) cl")

    let stackViewOne = UIStackView()
    let stackViewTwo = UIStackView()
        
    //var selectedGlassSizes: [DWGlassSizes] = [.s, .l, .xxl]
    var selectedGlassSizes = [Double]()

    var user: User!
    var unit: DWUnits!
    var unitString = "cl"

    
    init(profile: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = profile
        self.unit = user.units
        if self.unit == DWUnits.oz {
            self.unitString = "oz"
        }
        
        selectedGlassSizes.removeAll()
        selectedGlassSizes = self.user.preferredDrinkSize.convertFrom(unit: self.unit)
//        selectedGlassSizes.removeAll()
//        for s in user.preferredDrinkSize {
//            selectedGlassSizes.append(DWGlassSizes(rawValue: s)!)
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureSizeButtons()
        configureStackView()
        layoutUI()
    }
    
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = UIColor(cgColor: DWColors.lightBlackColor)
    }
    
    
    private func configureSizeButtons() {
        
        
        sButton.tag = 0
        sButton.setTitle("\(DWGlassSizes.s.convert(to: unit)) \(unitString)")
        sButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        configureButtonUnselected(button: sButton)
        
        mButton.tag = 1
        mButton.setTitle("\(DWGlassSizes.m.convert(to: unit)) \(unitString)")
        mButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        configureButtonUnselected(button: mButton)
        
        lButton.tag = 2
        lButton.setTitle("\(DWGlassSizes.l.convert(to: unit)) \(unitString)")
        lButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        configureButtonUnselected(button: lButton)
        
        xlButton.tag = 3
        xlButton.setTitle("\(DWGlassSizes.xl.convert(to: unit)) \(unitString)")
        xlButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        configureButtonUnselected(button: xlButton)
        
        xxlButton.tag = 4
        xxlButton.setTitle("\(DWGlassSizes.xxl.convert(to: unit)) \(unitString)")
        xxlButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        configureButtonUnselected(button: xxlButton)
        
        for s in user.preferredDrinkSize.prefArray {
            switch s {
            case .s:
                configureButtonSelected(button: sButton)
            case .m:
                configureButtonSelected(button: mButton)
            case .l:
                configureButtonSelected(button: lButton)
            case .xl:
                configureButtonSelected(button: xlButton)
            case .xxl:
                configureButtonSelected(button: xxlButton)
            }
       }
    }
    
    
    func configureButtonSelected(button: DWButton) {
        button.set(textColor: DWColors.whiteColor)
        button.backgroundColor = UIColor(cgColor: DWColors.greenColor)
    }
    
    
    func configureButtonUnselected(button: DWButton) {
        button.set(textColor: DWColors.grayColor)
        button.backgroundColor = .white
    }
    
    @objc func buttonTapped(sender: DWButton) {
        let size: DWGlassSizes
        
        switch sender.tag {
        case 0:
            size = .s
        case 1:
            size = .m
        case 2:
            size = .l
        case 3:
            size = .xl
        case 4:
            size = .xxl
        default:
            size = .s
        }
        
        if user.preferredDrinkSize.prefArray.contains(size) { // s is already selected
            sender.set(textColor: DWColors.grayColor)
            sender.backgroundColor = .white
            user.preferredDrinkSize.prefArray.firstIndex(of: size).map { selectedGlassSizes.remove(at: $0) }
            print(selectedGlassSizes)
        } else {
            if selectedGlassSizes.count < 3 { // else already 3 buttons selected
                sender.set(textColor: DWColors.whiteColor)
                sender.backgroundColor = UIColor(cgColor: DWColors.greenColor)
                user.preferredDrinkSize.prefArray.append(size)
            }
        }
    }
    
    
    private func layoutUI() {
        view.addSubview(glassSizeLabel)
        view.addSubview(stackViewOne)
        view.addSubview(stackViewTwo)

        glassSizeLabel.text = "🥛 Preferred glass sizes"
        
        let padding: CGFloat = 20
        stackViewOne.translatesAutoresizingMaskIntoConstraints = false
        stackViewTwo.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
           glassSizeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
           glassSizeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
           glassSizeLabel.heightAnchor.constraint(equalToConstant: 30),
            
           stackViewOne.topAnchor.constraint(equalTo: glassSizeLabel.bottomAnchor, constant: padding),
           stackViewOne.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           stackViewOne.widthAnchor.constraint(equalToConstant: view.frame.width/1.5),
           stackViewOne.heightAnchor.constraint(equalToConstant: 30),
            
           stackViewTwo.topAnchor.constraint(equalTo: stackViewOne.bottomAnchor, constant: padding),
           stackViewTwo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           stackViewTwo.widthAnchor.constraint(equalToConstant: view.frame.width/2),
           stackViewTwo.heightAnchor.constraint(equalToConstant: 30)
            
   
        ])
    }
    
    private func configureStackView() {
        stackViewOne.axis = .horizontal
        stackViewOne.distribution = .fillEqually
        stackViewOne.spacing = 20
        
        stackViewTwo.axis = .horizontal
        stackViewTwo.distribution = .fillEqually
        stackViewTwo.spacing = 20
        
        stackViewOne.addArrangedSubview(sButton)
        stackViewOne.addArrangedSubview(mButton)
        stackViewOne.addArrangedSubview(lButton)
        
        stackViewTwo.addArrangedSubview(xlButton)
        stackViewTwo.addArrangedSubview(xxlButton)

    }

}


