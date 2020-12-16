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
            
            cell.confirmed_Total_Amount.text = String(SharedData.Covid_cases_all[SharedData.CurrentCountry!].cases)
            cell.confirmed_Change.text = String("+\(SharedData.Covid_cases_all[SharedData.CurrentCountry!].todayCases)")
            
            cell.Recovered_Total_Amount.text = String(SharedData.Covid_cases_all[SharedData.CurrentCountry!].recovered)
            cell.Recovered_Change.text = String("+\(SharedData.Covid_cases_all[SharedData.CurrentCountry!].todayRecovered)")
            
            cell.Deaths_Total_Amount.text = String(SharedData.Covid_cases_all[SharedData.CurrentCountry!].deaths)
            cell.Deaths_Change.text = String("+\(SharedData.Covid_cases_all[SharedData.CurrentCountry!].todayDeaths)")
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentChartCell", for: indexPath) as! CurrentChart_TableViewCell
            
            cell.current_piechart.chartDescription?.enabled = false
            cell.current_piechart.drawHoleEnabled = false
            cell.current_piechart.rotationAngle = 0
            cell.current_piechart.isUserInteractionEnabled = false
            
            
            // RANDOM TEST DATA
            var entries: [PieChartDataEntry] = Array()
            entries.append(PieChartDataEntry(value: 50.0, label: "Takeout"))
            entries.append(PieChartDataEntry(value: 30.0, label: "Healthy Food"))
            entries.append(PieChartDataEntry(value: 20.0, label: "Soft Drink"))
            entries.append(PieChartDataEntry(value: 10.0, label: "Water"))
            entries.append(PieChartDataEntry(value: 40.0, label: "Home Meals"))
            
            let dataSet = PieChartDataSet(entries: entries, label: "")
            
            dataSet.drawValuesEnabled = false
            
            cell.current_piechart.data = PieChartData(dataSet: dataSet)

            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {	
        return 200.0
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

