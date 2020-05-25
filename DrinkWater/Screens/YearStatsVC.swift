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

class YearStatsVC: UIViewController, ChartViewDelegate {
    private var months: [String]! = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    private var statsLabel = DWTitleLabel(textAlignment: .center, fontSize: 17)
    private var statsBoldLabel = DWBoldLabel(textAlignment: .left, fontSize: 17)
    private var statsStackView = UIStackView()


    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        
        
        chartView.backgroundColor = .black
        chartView.rightAxis.enabled = false
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(4, force: true)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 105
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.setLabelCount(12, force: false)
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.axisLineColor = .white
        
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        chartView.xAxis.granularity = 1
        chartView.legend.enabled = false
        
        chartView.isUserInteractionEnabled = false

        
        chartView.animate(xAxisDuration: 1.5)
        
        return chartView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        configureStatsLabel()
        view.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: view)
       // lineChartView.height(view.frame.size.height/1.5)
        lineChartView.heightToWidth(of: view)
        
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lineChartView.animate(xAxisDuration: 1.5)
    }
    
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func setData() {
        let set1 = LineChartDataSet(entries: yValues)
        set1.mode = .horizontalBezier
        set1.drawCirclesEnabled = false
        set1.lineWidth = 3
        set1.cubicIntensity = 0.0
        set1.setColor(UIColor(cgColor: DWColors.greenColor))
        
        set1.fill = Fill(CGColor: DWColors.greenColor)
        set1.fillAlpha = 0.3
        set1.drawFilledEnabled = true
        
        set1.drawHorizontalHighlightIndicatorEnabled = false
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        lineChartView.data = data
        
    }
    
    
    private func configureStatsLabel() {
        view.addSubview(statsStackView)
           
        statsBoldLabel.text = "Year "
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
    
    
    let yValues: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 70),
        ChartDataEntry(x: 1.0, y: 50),
        ChartDataEntry(x: 2.0, y: 100),
        ChartDataEntry(x: 3.0, y: 80),
        ChartDataEntry(x: 4.0, y: 20),
        ChartDataEntry(x: 5.0, y: 70),
        ChartDataEntry(x: 6.0, y: 100),
        ChartDataEntry(x: 7.0, y: 100),
        ChartDataEntry(x: 8.0, y: 40),
        ChartDataEntry(x: 9.0, y: 60),
        ChartDataEntry(x: 10.0, y: 80),
        ChartDataEntry(x: 11.0, y: 100),
        
    ]

}

