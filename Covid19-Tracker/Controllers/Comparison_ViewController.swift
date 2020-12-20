//
//  Comparison_ViewController.swift
//  Covid19-Tracker
//
//  Created by Marco Exner on 18.12.20.
//  Copyright © 2020 Marco Exner. All rights reserved.
//

import UIKit
import Charts

class Comparison_ViewController: UIViewController {
    @IBOutlet weak var country_label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        country_label.text = SharedData.Covid_cases_all[SharedData.CurrentCountry!].country + " vs. " + SharedData.Covid_cases_all[SharedData.CompareCountry!].country 
        view.backgroundColor = .clear
    }

}


extension Comparison_ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath) as! DetailsCell_TableViewCell
            
            cell.confirmed_Total_Amount.text = String(SharedData.Covid_cases_all[SharedData.CompareCountry!].cases)
            
            cell.confirmed_Change.text = String(SharedData.Covid_cases_all[SharedData.CurrentCountry!].cases - SharedData.Covid_cases_all[SharedData.CompareCountry!].cases)
            
           
            
            cell.Recovered_Total_Amount.text = String(SharedData.Covid_cases_all[SharedData.CompareCountry!].recovered)
            
            cell.Recovered_Change.text = String(SharedData.Covid_cases_all[SharedData.CurrentCountry!].recovered - SharedData.Covid_cases_all[SharedData.CompareCountry!].recovered)
            
            cell.Deaths_Total_Amount.text = String(SharedData.Covid_cases_all[SharedData.CompareCountry!].deaths)
            
            cell.Deaths_Change.text = String(SharedData.Covid_cases_all[SharedData.CurrentCountry!].deaths - SharedData.Covid_cases_all[SharedData.CompareCountry!].deaths)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentChartCell", for: indexPath) as! CurrentChart_TableViewCell
            
            cell.current_piechart.chartDescription?.enabled = false
            cell.current_piechart.drawHoleEnabled = true
            cell.current_piechart.rotationAngle = 0
            // cell.current_piechart.isUserInteractionEnabled = false
            
            
            var entries: [PieChartDataEntry] = Array()
            entries.append(PieChartDataEntry(value: Double(SharedData.Covid_cases_all[SharedData.CurrentCountry!].cases), label: String("Confirmed\(SharedData.Covid_cases_all[SharedData.CurrentCountry!].cases)")))
            
            entries.append(PieChartDataEntry(value:Double (SharedData.Covid_cases_all[SharedData.CurrentCountry!].recovered), label: String("Recovered\(SharedData.Covid_cases_all[SharedData.CurrentCountry!].recovered)")))
            
            entries.append(PieChartDataEntry(value: Double(SharedData.Covid_cases_all[SharedData.CurrentCountry!].deaths), label:String ("Deaths \(SharedData.Covid_cases_all[SharedData.CurrentCountry!].deaths)")))
            
            
            
            let dataSet = PieChartDataSet(entries: entries, label: "")
            var colors : [UIColor] = []
            colors.append(UIColor.orange)
            colors.append(UIColor.green)
            colors.append(UIColor.red)
            dataSet.drawValuesEnabled = false
            dataSet.colors = colors
            cell.current_piechart.data = PieChartData(dataSet: dataSet)

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150.0
        }
        else {
            return 450.0
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SharedData.CompareCountry = nil
    }
}
