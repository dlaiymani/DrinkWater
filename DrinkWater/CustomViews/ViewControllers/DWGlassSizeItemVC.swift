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
        
    var selectedGlassSizes: [DWGlassSizes] = [.s, .l, .xxl]

    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureSexButtons()
        configureStackView()
        layoutUI()
    }
    
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = UIColor(cgColor: DWColors.lightBlackColor)
    }
    
    private func configureSexButtons() {
        mButton.set(textColor: DWColors.grayColor)
        xlButton.set(textColor: DWColors.grayColor)
        
        sButton.tag = 0
        sButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        mButton.tag = 1
        mButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        lButton.tag = 2
        lButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        xlButton.tag = 3
        xlButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        xxlButton.tag = 4
        xxlButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
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
        
        if selectedGlassSizes.contains(size) { // s is already selected
            sender.set(textColor: DWColors.grayColor)
            sender.backgroundColor = .white
            selectedGlassSizes.firstIndex(of: size).map { selectedGlassSizes.remove(at: $0) }
            print(selectedGlassSizes)
        } else {
            if selectedGlassSizes.count < 3 { // else already 3 buttons selected
                sender.set(textColor: DWColors.whiteColor)
                sender.backgroundColor = UIColor(cgColor: DWColors.greenColor)
                selectedGlassSizes.append(size)
                print(selectedGlassSizes)
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


