//
//  StatsVC.swift
//  DrinkWater
//
//  Created by David Laiymani on 27/04/2020.
//  Copyright © 2020 David Laiymani. All rights reserved.
//

import UIKit
import Charts
import TinyConstraints

class WeekStatsVC2: UIViewController, ChartViewDelegate {
    private var months: [String]! = ["M", "T", "W", "T", "F", "S", "S"]
    
    private var statsLabel = DWTitleLabel(textAlignment: .center, fontSize: 17)
    private var statsBoldLabel = DWBoldLabel(textAlignment: .left, fontSize: 17)
    private var statsStackView = UIStackView()

    
    lazy var barChartView: BarChartView = {
        let chartView = BarChartView()
        
        chartView.backgroundColor = .black
        chartView.rightAxis.enabled = false
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(4, force: true)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 100
        yAxis.enabled = false
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.setLabelCount(12, force: false)
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.axisLineColor = .white
        
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        chartView.xAxis.granularity = 1
        
        chartView.drawBarShadowEnabled = true
        chartView.legend.enabled = false
        
        chartView.isUserInteractionEnabled = false
        
        chartView.animate(yAxisDuration: 1.5)
        
        return chartView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        configureStatsLabel()
        view.addSubview(barChartView)
        barChartView.centerInSuperview()
        barChartView.width(to: view)
       // lineChartView.height(view.frame.size.height/1.5)
        barChartView.heightToWidth(of: view)
        
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        barChartView.animate(yAxisDuration: 1.5)
    }
    
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func setData() {
        let set1 = BarChartDataSet(entries: yValues)
        
        set1.setColor(UIColor(cgColor: DWColors.greenColor))
        set1.barShadowColor = UIColor(cgColor: DWColors.lightGreenColor)
        

        
        let data = BarChartData(dataSet: set1)
        data.setDrawValues(false)
        data.barWidth = 0.4

        barChartView.data = data
        
    }
    
    
    private func configureStatsLabel() {
        view.addSubview(statsStackView)
           
        statsBoldLabel.text = "Week "
        statsLabel.text = "achievements"
        
        statsStackView.axis = .horizontal
        statsStackView.distribution = .equalSpacing
        statsStackView.addArrangedSubview(statsBoldLabel)
        statsStackView.addArrangedSubview(statsLabel)
        statsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 0)
        ])
    }
    
    
    let yValues: [BarChartDataEntry] = [
        BarChartDataEntry(x: 0.0, y: 70),
        BarChartDataEntry(x: 1.0, y: 50),
        BarChartDataEntry(x: 2.0, y: 100),
        BarChartDataEntry(x: 3.0, y: 80),
        BarChartDataEntry(x: 4.0, y: 20),
        BarChartDataEntry(x: 5.0, y: 70),
        BarChartDataEntry(x: 6.0, y: 100),
    ]

}


