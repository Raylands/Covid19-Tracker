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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath) as! DetailsCell_TableViewCell
            
            let formatter = NumberFormatter()
            formatter.numberStyle = NumberFormatter.Style.decimal
            formatter.locale = Locale(identifier: "de_DE")
            
            cell.confirmed_Total_Amount.text = formatter.string(for: SharedData.Covid_cases_all[SharedData.CurrentCountry!].cases)
            
            cell.confirmed_Change.text = "+" +  formatter.string(for:SharedData.Covid_cases_all[SharedData.CurrentCountry!].todayCases)!
            
            cell.Recovered_Total_Amount.text = formatter.string(for:SharedData.Covid_cases_all[SharedData.CurrentCountry!].recovered)
            
            cell.Recovered_Change.text = "+" +  formatter.string(for:SharedData.Covid_cases_all[SharedData.CurrentCountry!].todayRecovered)!
            
            cell.Deaths_Total_Amount.text = formatter.string(for:SharedData.Covid_cases_all[SharedData.CurrentCountry!].deaths)
            
            cell.Deaths_Change.text = "+" +  formatter.string(for: SharedData.Covid_cases_all[SharedData.CurrentCountry!].todayDeaths)!
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentChartCell", for: indexPath) as! CurrentChart_TableViewCell
            
            cell.current_piechart.chartDescription?.enabled = false
            cell.current_piechart.drawHoleEnabled = false
            cell.current_piechart.rotationAngle = 0
            //cell.current_piechart.isUserInteractionEnabled = false
            
            
                        var entries: [PieChartDataEntry] = Array()
            entries.append(PieChartDataEntry(value: Double(SharedData.Covid_cases_all[SharedData.CurrentCountry!].cases), label: String("Confirmed\(SharedData.Covid_cases_all[SharedData.CurrentCountry!].cases)")))
            
            entries.append(PieChartDataEntry(value:Double (SharedData.Covid_cases_all[SharedData.CurrentCountry!].recovered), label: String("Recovered\(SharedData.Covid_cases_all[SharedData.CurrentCountry!].recovered)")))
            
            entries.append(PieChartDataEntry(value: Double(SharedData.Covid_cases_all[SharedData.CurrentCountry!].deaths), label:String ("Deaths \(SharedData.Covid_cases_all[SharedData.CurrentCountry!].deaths)")))
            
            
            let dataSet = PieChartDataSet(entries: entries, label: "")
            var colors : [UIColor] = []
            let format = NumberFormatter()
            format.numberStyle = .none
            let formatter = DefaultValueFormatter(formatter : format)
            colors.append(UIColor.orange)
            colors.append(UIColor.green)
            colors.append(UIColor.red)
            dataSet.colors = colors
            dataSet.drawValuesEnabled = false
            
            cell.current_piechart.data = PieChartData(dataSet: dataSet)
            cell.current_piechart.data?.setValueFormatter(formatter)
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
        SharedData.CurrentCountry = nil
    }
    
    @objc func add_compare() -> Void {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "main_view") as! Countries_ViewController

        self.present(secondViewController, animated: true)
    }
}

