//
//  Bar_Chart_ViewController.swift
//  Covid19-Tracker
//
//  Created by Francis TRAN on 16/12/2020.
//  Copyright © 2020 Marco Exner. All rights reserved.
//

import UIKit
import Charts
class Bar_Chart_ViewController: UIViewController, ChartViewDelegate {

    var barChart = BarChartView()
    var DeathNumberStored : Int = 0
    var ConfirmedNumberStored : Int = 0
    var RecoveredNumberStored : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        barChart.delegate = self
    
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews () {
        
        super.viewDidLayoutSubviews()
        barChart.frame = CGRect(x: 0, y:0,
                                width : self.view.frame.size.width,
                                height:self.view.frame.size.width)
        
        barChart.center = view.center
        view.addSubview(barChart)
        var entries: [BarChartDataEntry] = Array()
        
        //value of our pieChart
        
       // entries.append(BarChartDataEntry(value: Double(DeathNumberStored), label: "Deaths"))
        
      //  entries.append(BarChartDataEntry(value: Double(ConfirmedNumberStored), label: "Confirmed"))
      //  entries.append(BarChartDataEntry(value: Double(RecoveredNumberStored), label: "Recovered"))
        
        
        let set = BarChartDataSet(entries : entries)
        set.colors = ChartColorTemplates.colorful()
        let data = BarChartData(dataSet: set)
        
        barChart.data = data
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
