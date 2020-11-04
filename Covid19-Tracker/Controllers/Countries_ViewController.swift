//
//  Countries_ViewController.swift
//  Covid19-Tracker
//
//  Created by Marco Exner on 04.11.20.
//  Copyright © 2020 Marco Exner. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Country_proto"
private let API_URL_All_Countires = "https://covid19-api.com/country/all?format=json"

class Countries_ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var Search_Bar: UISearchBar!
    @IBOutlet var Countries_CollectionView: UICollectionView!
    
    var Covid_cases_all: [Covid_Data] = []
    var Covid_cases: [Covid_Data] = []
    var dead: [Covid_Data] = []
    var countries: [String] = []
    
    override func viewDidLoad() {
            
        super.viewDidLoad()
        navigationItem.title = "Covid-Tracker"
        
        Countries_CollectionView.delegate = self;
        Countries_CollectionView.dataSource = self;
        
        Search_Bar.delegate = self;
        
        getData(url: API_URL_All_Countires) {
            [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                break
            case .success(let data):
                for cases in data {
                    // Cleanse data from Countries without country code
                    if cases.code != nil /*|| cases.lastUpdate != nil || cases.lastChange != nil*/{
                        self?.Covid_cases_all.append(cases)
                    }
                }
                break
            }
        }
        Covid_cases = Covid_cases_all
        Countries_CollectionView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
}

extension Countries_ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.Covid_cases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CountryCell_CollectionViewCell
    
        // Configure the cell
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        cell.Country_label.text = Covid_cases[indexPath.item].country
        
        return cell
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.Covid_cases.removeAll()
                 
        for item in self.Covid_cases_all {
            if (item.country.lowercased().starts(with: searchBar.text!.lowercased()) || item.code!.lowercased().starts(with: searchBar.text!.lowercased())) {
                self.Covid_cases.append(item)
            }
        }
             
        if (searchBar.text!.isEmpty) {
            self.Covid_cases = self.Covid_cases_all
        }
        
        self.Countries_CollectionView.reloadData()
    }
}
