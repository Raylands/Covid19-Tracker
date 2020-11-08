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
        let main = Countries_ViewController()
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
    extension Details_ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Details_proto", for: indexPath) as! DetailsCell_CollectionViewCell
        // Configure the cell
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        return cell
    }
}
