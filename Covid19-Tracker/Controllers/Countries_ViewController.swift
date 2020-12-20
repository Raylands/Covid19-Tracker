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
private let API_URL_All_COUNTRIES_TODAY = "https://disease.sh/v3/covid-19/countries?allowNull=false"
private let API_URL_All_COUNTRIES_YESTERDAY = "https://disease.sh/v3/covid-19/countries?yesterday=true&allowNull=false"
class Countries_ViewController: UIViewController {

    @IBOutlet weak var Search_Bar: UISearchBar!
    @IBOutlet var Countries_CollectionView: UICollectionView!
    
    override func viewDidLoad() {
            
        super.viewDidLoad()
        navigationItem.title = "Covid-Tracker"
        
        Countries_CollectionView.delegate = self;
        Countries_CollectionView.dataSource = self;
        
        Search_Bar.delegate = self;
        
        getData(url: API_URL_All_COUNTRIES_TODAY) {
            [weak self] result in
            switch result {
            case .failure(let error):
                debugPrint(error)
                break
            case .success(let data):
                for cases in data {
                    // filter invalid data
                    if cases.countryInfo._id != nil && cases.countryInfo.iso2 != nil && cases.countryInfo.iso3 != nil {
                        SharedData.Covid_cases_all.append(cases)
                    }
                }
                SharedData.Covid_cases = SharedData.Covid_cases_all
                self?.Countries_CollectionView.reloadData()
                break
            }
        }
        
        getData(url: API_URL_All_COUNTRIES_YESTERDAY) {
            result in
            switch result {
            case .failure(let error):
                debugPrint(error)
                break
            case .success(let data):
                for cases in data {
                    // filter invalid data
                    if cases.countryInfo._id != nil && cases.countryInfo.iso2 != nil && cases.countryInfo.iso3 != nil {
                        SharedData.Covid_cases_all_day_before.append(cases)
                    }
                }
                break
            }
        }
    }
}

extension Countries_ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if UIDevice.current.orientation.isLandscape {
            let cellsAcross: CGFloat = 4
            let spaceBetweenCells: CGFloat = 50
            let dim = (collectionView.bounds.width - (cellsAcross-1) * spaceBetweenCells) / cellsAcross
            return CGSize(width: dim, height: dim/1.5)
        }
        else {
            let cellsAcross: CGFloat = 2
            let spaceBetweenCells: CGFloat = 50
            let dim = (collectionView.bounds.width - (cellsAcross-1) * spaceBetweenCells) / cellsAcross
            return CGSize(width: dim, height: dim/1.5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return SharedData.Covid_cases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CountryCell_CollectionViewCell
        // Configure the cell
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true

        let url = URL(string: SharedData.Covid_cases[indexPath.item].countryInfo.flag)
        let data = try? Data(contentsOf: url!)
        cell.Flag_image.image = UIImage(data: data!)

        cell.Country_label.text = SharedData.Covid_cases[indexPath.item].country
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CountryCell_CollectionViewCell
        
        if SharedData.CurrentCountry != nil {
            SharedData.CompareCountry = SharedData.Covid_cases_all.firstIndex(where: { (cases) -> Bool in
                cases.country.elementsEqual(cell.Country_label.text!)
              })
            self.performSegue(withIdentifier: "seg_comparison", sender: self)
            return
        }
        else {
            SharedData.CurrentCountry = SharedData.Covid_cases_all.firstIndex(where: { (cases) -> Bool in
                cases.country.elementsEqual(cell.Country_label.text!)
              })
            self.performSegue(withIdentifier: "seg_details", sender: self)
            return
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        Countries_CollectionView.collectionViewLayout.invalidateLayout()
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        SharedData.Covid_cases.removeAll()
                 
        for item in SharedData.Covid_cases_all {
            if (item.country.lowercased().starts(with: searchBar.text!.lowercased()) || item.countryInfo.iso2!.lowercased().starts(with: searchBar.text!.lowercased()) || item.countryInfo.iso3!.lowercased().starts(with: searchBar.text!.lowercased())) {
                if  !SharedData.Covid_cases.contains(item) {
                    SharedData.Covid_cases.append(item)
                }
            }
        }
             
        if (searchBar.text!.isEmpty) {
            SharedData.Covid_cases = SharedData.Covid_cases_all
        }
        
        self.Countries_CollectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
}
