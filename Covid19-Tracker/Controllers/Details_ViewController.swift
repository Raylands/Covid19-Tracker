//
//  Details_ViewController.swift
//  Covid19-Tracker
//
//  Created by Marco Exner on 08.11.20.
//  Copyright © 2020 Marco Exner. All rights reserved.
//

import UIKit

class Details_ViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
extension Details_ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var identifier:Int = 0
        
        for country in SharedData.Covid_cases_all {
            identifier += 1
        
            if country.country.elementsEqual(SharedData.CurrentCountry!) {
                break
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath) as! DetailsCell_TableViewCell
        
        cell.confirmed_Total_Amount.text = String(SharedData.Covid_cases_all[identifier].confirmed)
        
        cell.Recovered_Total_Amount.text = String(SharedData.Covid_cases_all[identifier].recovered)
        
        cell.Deaths_Total_Amount.text = String(SharedData.Covid_cases_all[identifier].deaths)
        
        return cell
    }
}
