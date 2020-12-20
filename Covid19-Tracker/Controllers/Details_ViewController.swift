//
//  Details_ViewController.swift
//  Covid19-Tracker
//
//  Created by Marco Exner on 08.11.20.
//  Copyright © 2020 Marco Exner. All rights reserved.
//

import UIKit
import Charts

class Details_ViewController: UIViewController {
    @IBOutlet weak var Navigation: UINavigationItem!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.title = SharedData.Covid_cases_all[SharedData.CurrentCountry!].country
        
        Navigation.rightBarButtonItem = UIBarButtonItem(title: "Compare", style: .plain, target: self, action: #selector(add_compare))
        
        view.backgroundColor = .clear

        
        // Do any additional setup after loading the view.
    }
    
}
extension Details_ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath) as! DetailsCell_TableViewCell
            
            let formatter = NumberFormatter()
            formatter.numberStyle = NumberFormatter.Style.decimal
            formatter.locale = Locale(identifier: "de_DE")
            
            cell.confirmed_Total_Amount.text = formatter.string(for: SharedData.Covid_cases_all[SharedData.CurrentCountry!].cases)
            
            cell.confirmed_Change.text = (SharedData.Covid_cases_all[SharedData.CurrentCountry!].todayCases >= 0 ? "▲ " : "▼ ") +  formatter.string(for:SharedData.Covid_cases_all[SharedData.CurrentCountry!].todayCases)!
            
            cell.Recovered_Total_Amount.text = formatter.string(for:SharedData.Covid_cases_all[SharedData.CurrentCountry!].recovered)
            
            cell.Recovered_Change.text = (SharedData.Covid_cases_all[SharedData.CurrentCountry!].todayRecovered >= 0 ? "▲ " : "▼ ") +  formatter.string(for:SharedData.Covid_cases_all[SharedData.CurrentCountry!].todayRecovered)!
            
            cell.Deaths_Total_Amount.text = formatter.string(for:SharedData.Covid_cases_all[SharedData.CurrentCountry!].deaths)
            
            cell.Deaths_Change.text = (SharedData.Covid_cases_all[SharedData.CurrentCountry!].todayDeaths >= 0 ? "▲ " : "▼ ") +  formatter.string(for: SharedData.Covid_cases_all[SharedData.CurrentCountry!].todayDeaths)!
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentChartCell", for: indexPath) as! CurrentChart_TableViewCell
            
            cell.current_piechart.chartDescription?.enabled = false
            cell.current_piechart.drawHoleEnabled = true
            cell.current_piechart.drawSlicesUnderHoleEnabled = false
            cell.current_piechart.holeColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
            cell.current_piechart.isUserInteractionEnabled = false
            
            cell.current_piechart.legend.textColor = .white
            cell.current_piechart.legend.form = .circle
            cell.current_piechart.legend.formSize = 12
            cell.current_piechart.legend.horizontalAlignment = .center
            cell.current_piechart.legend.xEntrySpace = 10
            
            cell.current_piechart.drawEntryLabelsEnabled = false
            cell.current_piechart.usePercentValuesEnabled = true
            
            var entries: [PieChartDataEntry] = []
            entries.append(PieChartDataEntry(value: Double(SharedData.Covid_cases_all[SharedData.CurrentCountry!].cases), label: "Confirmed"))
            
            entries.append(PieChartDataEntry(value: Double (SharedData.Covid_cases_all[SharedData.CurrentCountry!].recovered), label: "Recovered"))
            
            entries.append(PieChartDataEntry(value: Double(SharedData.Covid_cases_all[SharedData.CurrentCountry!].deaths), label:"Deaths"))
            
            let dataSet = PieChartDataSet(entries: entries, label: "")
            
            dataSet.colors = [.systemOrange, .systemGreen, .systemRed]
            dataSet.drawValuesEnabled = true

            dataSet.valueColors = [.black, .black, .white]
            
            dataSet.sliceSpace = 3
            
            cell.current_piechart.data = PieChartData(dataSet: dataSet)

            let format = NumberFormatter()
            format.numberStyle = .percent
            format.locale = Locale(identifier: "de_DE")
            format.maximumFractionDigits = 2
            format.multiplier = 1.0
            format.percentSymbol = "%"
            let formatter = DefaultValueFormatter(formatter: format)
            
            cell.current_piechart.data!.setValueFormatter(formatter)
        
            
            cell.current_piechart.animate(xAxisDuration: 0.8, easingOption: .easeOutBack)
            
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
            entries.append(PieChartDataEntry(value: Double(SharedData.Covid_cases_all[SharedData.CurrentCountry!].active), label: "Active"))
            
            entries.append(PieChartDataEntry(value: Double (SharedData.Covid_cases_all[SharedData.CurrentCountry!].cases - SharedData.Covid_cases_all[SharedData.CurrentCountry!].active), label: "Total - Active"))
            
            let dataSet = PieChartDataSet(entries: entries, label: "")
            
            dataSet.colors = [.systemRed, .systemOrange]
            dataSet.drawValuesEnabled = true

            dataSet.valueColors = [.white, .black]
            
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
            return 150.0
        }
        else {
            return 450.0
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SharedData.CurrentCountry = nil
    }
    
    @objc func add_compare() -> Void {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "main_view") as! Countries_ViewController
        
        SharedData.Covid_cases = SharedData.Covid_cases_all
        self.present(secondViewController, animated: true)
    }
}

