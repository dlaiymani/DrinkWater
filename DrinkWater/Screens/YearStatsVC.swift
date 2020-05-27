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
    private var days: [String]! = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    private var daysMonth: [String]! = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31",]
    
    private var statsStackView = UIStackView()

    var statsType = StatsType.week
    
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
        
        chartView.xAxis.granularity = 1
        chartView.legend.enabled = false
        
        chartView.isUserInteractionEnabled = false

        
        chartView.animate(xAxisDuration: 1.5)
        
        return chartView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)
        
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
   //     lineChartView.animate(xAxisDuration: 1.5)
    }
    
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func setData() {
        var set1: LineChartDataSet!

        switch statsType {
        case .week:
            set1 = LineChartDataSet(entries: weekValues)
            lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: days)
        case .month:
            set1 = LineChartDataSet(entries: monthValues)
            lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: daysMonth)
        case .year:
            set1 = LineChartDataSet(entries: yearValues)
            lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        }
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
        lineChartView.animate(xAxisDuration: 1.5)

        
    }
    
    let weekValues: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 70),
        ChartDataEntry(x: 1.0, y: 50),
        ChartDataEntry(x: 2.0, y: 100),
        ChartDataEntry(x: 3.0, y: 80),
        ChartDataEntry(x: 4.0, y: 20),
        ChartDataEntry(x: 5.0, y: 70),
        ChartDataEntry(x: 6.0, y: 100),
    ]
    
    
    let yearValues: [ChartDataEntry] = [
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

    
    let monthValues: [ChartDataEntry] = [
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
        ChartDataEntry(x: 12.0, y: 70),
        ChartDataEntry(x: 13.0, y: 50),
        ChartDataEntry(x: 14.0, y: 100),
        ChartDataEntry(x: 15.0, y: 80),
        ChartDataEntry(x: 16.0, y: 20),
        ChartDataEntry(x: 17.0, y: 70),
        ChartDataEntry(x: 18.0, y: 100),
        ChartDataEntry(x: 19.0, y: 100),
        ChartDataEntry(x: 20.0, y: 40),
        ChartDataEntry(x: 21.0, y: 60),
        ChartDataEntry(x: 22.0, y: 80),
        ChartDataEntry(x: 23.0, y: 100),
        ChartDataEntry(x: 24.0, y: 70),
        ChartDataEntry(x: 25.0, y: 50),
        ChartDataEntry(x: 26.0, y: 100),
        ChartDataEntry(x: 27.0, y: 80),
        ChartDataEntry(x: 28.0, y: 20),
        ChartDataEntry(x: 29.0, y: 70),
        ChartDataEntry(x: 30.0, y: 100),
        ChartDataEntry(x: 31.0, y: 100)
    ]
}

