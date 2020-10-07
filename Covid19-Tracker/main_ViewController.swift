//
//  main_ViewController.swift
//  Covid19-Tracker
//
//  Created by Marco Exner on 07.10.20.
//  Copyright © 2020 Marco Exner. All rights reserved.
//

import UIKit

class main_ViewController: UIViewController {

    var Covid_cases: [Covid_Data]?;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData(url: "https://covid19-api.com/country/all?format=json") {
            [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                break
            case .success(let data):
                self?.Covid_cases = data
                for cases in data {
                    print(cases.country, "-",cases.lastUpdate ?? "No date found.")
                }
            }
        }
    }
}

