//
//  Countries_CollectionViewController.swift
//  Covid19-Tracker
//
//  Created by Marco Exner on 11.10.20.
//  Copyright © 2020 Marco Exner. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Country_proto"
private let API_URL_All_Countires = "https://covid19-api.com/country/all?format=json"

class Countries_CollectionViewController: UICollectionViewController, UISearchBarDelegate {

    @IBOutlet var Countires_CollectionView: UICollectionView!
    
    
    var Covid_cases_all: [Covid_Data] = []
    var Covid_cases: [Covid_Data] = []
    var dead: [Covid_Data] = []
    var countries: [String] = []
    
    override func viewDidLoad() {
            
        super.viewDidLoad()
        navigationItem.title = "Covid-Tracker"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
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
        Countires_CollectionView.reloadData()
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

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.Covid_cases.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CountryCell_CollectionViewCell
    
        // Configure the cell
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        cell.Country_label.text = Covid_cases[indexPath.item].country
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
     
        let searchView: SearchBarView = Countires_CollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBar", for: indexPath) as! SearchBarView
        
        searchView.searchBar.delegate = self
        return searchView
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
        
        self.Countires_CollectionView.reloadData()
    }
    

    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
