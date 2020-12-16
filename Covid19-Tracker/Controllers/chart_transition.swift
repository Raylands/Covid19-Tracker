//
//  chart_transition.swift
//  Covid19-Tracker
//
//  Created by Francis TRAN on 14/12/2020.
//  Copyright © 2020 Marco Exner. All rights reserved.
//

import Foundation
import UIKit
import Charts

class chart_transition : UIViewController, ChartViewDelegate {
    var pieChart = PieChartView()
    
    var DeathNumberStored : Int = 0
    var ConfirmedNumberStored : Int = 0
    var RecoveredNumberStored : Int = 0
    var verificationID = String()
    @IBAction func backButtonPress(_ sender: Any) {
    
    print("back button pressed ")
        self.performSegue(withIdentifier: "backSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChart.delegate = self
    
    }
    
    override func viewDidLayoutSubviews () {
        
        super.viewDidLayoutSubviews()
        pieChart.frame = CGRect(x: 0, y:0,
                                width : self.view.frame.size.width,
                                height:self.view.frame.size.width)
        
        pieChart.center = view.center
        view.addSubview(pieChart)
        var entries: [PieChartDataEntry] = Array()
        
        //value of our pieChart
        
        entries.append(PieChartDataEntry(value: Double(DeathNumberStored), label: "Deaths"))
        
        entries.append(PieChartDataEntry(value: Double(ConfirmedNumberStored), label: "Confirmed"))
        entries.append(PieChartDataEntry(value: Double(RecoveredNumberStored), label: "Recovered"))
        
        
        let set = PieChartDataSet(entries : entries)
        set.colors = ChartColorTemplates.colorful()
        let data = PieChartData(dataSet: set)
        pieChart.data = data
        pieChart.rotationAngle = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
