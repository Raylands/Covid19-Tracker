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
    
    var Covid_cases_all: [Covid_Data] = []
    var Covid_cases: [Covid_Data] = []
    
    override func viewDidLoad() {
            
        super.viewDidLoad()
        navigationItem.title = "Covid-Tracker"
        
        Countries_CollectionView.delegate = self;
        Countries_CollectionView.dataSource = self;
        
        Search_Bar.delegate = self;
        
        /*guard let url_tmp = URL.init(string: API_URL_All_Countires) else {
            return
        }
        
        URLSession.shared.dataTask(with: url_tmp, completionHandler: {data, abd, abc in
            guard let jsonData = data else {
                return
            }
            do{
                let response = try JSONDecoder().decode([Covid_Data].self, from: jsonData)
                print(response[0].country)
                print("Done")
                DispatchQueue.main.async {
                    print("From main thread: \(response[0].country)")
                    self.Covid_cases = response
                    self.Countries_CollectionView.reloadData()
                }
                //return
            } catch {
                //return
            }
            
            
            
            print("Data received!")
        
            
        }).resume()*/
        
        print("After JSON")
        
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
                self?.Covid_cases = self?.Covid_cases_all as! [Covid_Data]
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CountryCell_CollectionViewCell
        print("You selected cell \(cell.Country_label.text!)!")
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
