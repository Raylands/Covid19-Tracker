//
//  main_ViewController.swift
//  Covid19-Tracker
//
//  Created by Marco Exner on 07.10.20.
//  Copyright © 2020 Marco Exner. All rights reserved.
//

import UIKit

class main_ViewController: UIViewController {

    @IBOutlet weak var TableView: UITableView! //TODO: TableView implementation
    var Covid_cases: [Covid_Data]?
    var dead: [Covid_Data] = []
    var countries: [String] = []
    // hello is it working ???
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
                    self?.countries.append(cases.country)
                    print("\(cases.country) (\(cases.code ?? "XX"))", "-", cases.lastUpdate ?? "No date found.")
                    if cases.code == nil /*|| cases.lastUpdate == nil || cases.lastChange == nil*/{
                        self?.dead.append(cases)
                    }
                }
                print()
                for item in self!.dead {
                    print(item.country)
                }
            }
        }
    }
}

