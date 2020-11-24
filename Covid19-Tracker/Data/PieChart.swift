//
//  PieChart.swift
//  Covid19-Tracker
//
//  Created by Francis TRAN on 24/11/2020.
//  Copyright © 2020 Marco Exner. All rights reserved.
//

import UIKit
import Charts


class PieChart: UIViewController, ChartViewDelegate {

    @IBOutlet var pieView: PieChartView!
    
    var pieChart = PieChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
        override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pieChart.frame = CGRect (x:0 , y:0,
                                 width : self.view.frame.size.width,
                                 height : self.view.frame.size.width)
        pieChart.center = view.center
        view.addSubview(pieChart)
        
        var entries = [ChartDataEntry]()
        
        
        for x in 0..<10 {
            entries.append(ChartDataEntry(x: Double(x),
                                          y : Double (x)))
        }
        let set = PieChartDataSet (entries : entries)
        set.colors = ChartColorTemplates.pastel()
        let data = PieChartData(dataSet : set)
        pieChart.data = data
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


