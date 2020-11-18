//
//  Countries_ViewController.swift
//  Covid19-Tracker
//
//  Created by Marco Exner on 04.11.20.
//  Copyright © 2020 Marco Exner. All rights reserved.
//

import UIKit
import Foundation

private let reuseIdentifier = "Country_proto"
private let API_URL_All_Countires = "https://covid19-api.com/country/all?format=json"

class Countries_ViewController: UIViewController {

    @IBOutlet weak var Search_Bar: UISearchBar!
    @IBOutlet var Countries_CollectionView: UICollectionView!
    
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
                        SharedData.Covid_cases_all.append(cases)
                        
                    }
                }
                SharedData.Covid_cases = SharedData.Covid_cases_all as! [Covid_Data]
                self?.Countries_CollectionView.reloadData()
                break
            }
        }

    }

}

extension Countries_ViewController: UICollectionViewDelegate, UICollectionViewDataSource,  UISearchBarDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return SharedData.Covid_cases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CountryCell_CollectionViewCell
        // Configure the cell
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        cell.Country_label.text = SharedData.Covid_cases[indexPath.item].country
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CountryCell_CollectionViewCell
        
        SharedData.CurrentCountry = cell.Country_label.text
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        SharedData.Covid_cases.removeAll()
                 
        for item in SharedData.Covid_cases_all {
            if (item.country.lowercased().starts(with: searchBar.text!.lowercased()) || item.code!.lowercased().starts(with: searchBar.text!.lowercased())) {
                SharedData.Covid_cases.append(item)
            }
        }
             
        if (searchBar.text!.isEmpty) {
            SharedData.Covid_cases = SharedData.Covid_cases_all
        }
        
        self.Countries_CollectionView.reloadData()
    }
}
