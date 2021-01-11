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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath) as! DetailsCompareCell_TableViewCell
            
            let formatter = NumberFormatter()
            formatter.numberStyle = NumberFormatter.Style.decimal
            formatter.locale = Locale(identifier: "de_DE")
            
            cell.c1_Title.text = SharedData.Covid_cases_all[SharedData.CurrentCountry!].country
            
            cell.c1_confirmed_Total_Amount.text = formatter.string(for:SharedData.Covid_cases_all[SharedData.CurrentCountry!].cases)
            
            cell.c1_recovered_Total_Amount.text = formatter.string(for: SharedData.Covid_cases_all[SharedData.CurrentCountry!].recovered)
            
            cell.c1_deaths_Total_Amount.text = formatter.string(for: SharedData.Covid_cases_all[SharedData.CurrentCountry!].deaths)
            
            
            cell.c2_Title.text = SharedData.Covid_cases_all[SharedData.CompareCountry!].country
            
            cell.c2_confirmed_Total_Amount.text = formatter.string(for: SharedData.Covid_cases_all[SharedData.CompareCountry!].cases)
            
            cell.c2_recovered_Total_Amount.text = formatter.string(for: SharedData.Covid_cases_all[SharedData.CompareCountry!].recovered)
            
            cell.c2_deaths_Total_Amount.text = formatter.string(for: SharedData.Covid_cases_all[SharedData.CompareCountry!].deaths)
            
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentChartCell", for: indexPath) as! CurrentCompariosnChart_TableViewCell
            
            cell.current_barchart.chartDescription?.enabled = false
            cell.current_barchart.isUserInteractionEnabled = false
            cell.current_barchart.xAxis.labelTextColor = .white
            cell.current_barchart.leftAxis.labelTextColor = .white
            cell.current_barchart.rightAxis.labelTextColor = .white
            
            cell.current_barchart.legend.textColor = .white
            cell.current_barchart.legend.form = .circle
            cell.current_barchart.legend.formSize = 12
            cell.current_barchart.legend.horizontalAlignment = .center
            cell.current_barchart.legend.xEntrySpace = 10
        
            cell.current_barchart.legend.setCustom(entries: [
                LegendEntry(label: "Total cases", form: .circle, formSize: 12,
                            formLineWidth: 0, formLineDashPhase: 0, formLineDashLengths: nil, formColor: UIColor.systemOrange),
                LegendEntry(label: "Total recovered", form: .circle, formSize: 12,
                            formLineWidth: 0, formLineDashPhase: 0, formLineDashLengths: nil, formColor: UIColor.systemGreen),
                LegendEntry(label: "Total deaths", form: .circle, formSize: 12,
                            formLineWidth: 0, formLineDashPhase: 0, formLineDashLengths: nil, formColor: UIColor.systemRed)
            ])
            
            var entries: [BarChartDataEntry] = Array()
            entries.append(BarChartDataEntry(x: 1, yValues: [Double(SharedData.Covid_cases_all[SharedData.CurrentCountry!].cases)]))
            
            entries.append(BarChartDataEntry(x: 2, yValues: [Double(SharedData.Covid_cases_all[SharedData.CompareCountry!].cases)]))
            
            
            entries.append(BarChartDataEntry(x: 4, yValues: [Double(SharedData.Covid_cases_all[SharedData.CurrentCountry!].recovered)]))
            
            entries.append(BarChartDataEntry(x: 5, yValues: [Double(SharedData.Covid_cases_all[SharedData.CompareCountry!].recovered)]))
            
            
            entries.append(BarChartDataEntry(x: 7, yValues: [Double(SharedData.Covid_cases_all[SharedData.CurrentCountry!].deaths)]))
            
            entries.append(BarChartDataEntry(x: 8, yValues: [Double(SharedData.Covid_cases_all[SharedData.CompareCountry!].deaths)]))
            
            
            
            let dataSet = BarChartDataSet(entries: entries, label: "")
            
            dataSet.drawValuesEnabled = false
            dataSet.colors = [.systemOrange, .systemOrange, .systemGreen, .systemGreen, .systemRed, .systemRed]
            
            cell.current_barchart.data = BarChartData(dataSet: dataSet)
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActiveChartCell", for: indexPath) as! CurrentChart_TableViewCell
            
            cell.current_piechart.chartDescription?.enabled = false
            cell.current_piechart.drawHoleEnabled = true
            cell.current_piechart.drawSlicesUnderHoleEnabled = false
            cell.current_piechart.holeColor = UIColor.clear
            cell.current_piechart.isUserInteractionEnabled = false
            
            cell.current_piechart.legend.textColor = .white
            cell.current_piechart.legend.form = .circle
            cell.current_piechart.legend.formSize = 12
            cell.current_piechart.legend.horizontalAlignment = .center
            cell.current_piechart.legend.xEntrySpace = 10
            
            cell.current_piechart.drawEntryLabelsEnabled = false
            cell.current_piechart.usePercentValuesEnabled = false
            
            var entries: [PieChartDataEntry] = []
            entries.append(PieChartDataEntry(value: Double(SharedData.Covid_cases_all[SharedData.CurrentCountry!].active), label: SharedData.Covid_cases_all[SharedData.CurrentCountry!].country))
            
            entries.append(PieChartDataEntry(value: Double( SharedData.Covid_cases_all[SharedData.CompareCountry!].active), label: SharedData.Covid_cases_all[SharedData.CompareCountry!].country))
            
            let dataSet = PieChartDataSet(entries: entries, label: "")
            
            if entries[0].value > entries[1].value {
                dataSet.colors = [.systemRed, .systemOrange]
                dataSet.valueColors = [.white, .black]
            }
            else {
                dataSet.colors = [.systemOrange, .systemRed]
                dataSet.valueColors = [.black, .white]
            }
            dataSet.drawValuesEnabled = true

            dataSet.sliceSpace = 3
            
            cell.current_piechart.data = PieChartData(dataSet: dataSet)

            let format = NumberFormatter()
            format.numberStyle = .decimal
            format.locale = Locale(identifier: "de_DE")
            //format.maximumFractionDigits = 2
            let formatter = DefaultValueFormatter(formatter: format)
            
            cell.current_piechart.data!.setValueFormatter(formatter)
        
            
            cell.current_piechart.animate(xAxisDuration: 0.8, easingOption: .easeOutBack)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200.0
        }
        else {
            return 450.0
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        SharedData.CompareCountry = nil
    }
}
