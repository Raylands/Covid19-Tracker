//
//  DetailsCompareCell_TableViewCell.swift
//  Covid19-Tracker
//
//  Created by Marco Exner on 20.12.20.
//  Copyright © 2020 Marco Exner. All rights reserved.
//

import UIKit

class DetailsCompareCell_TableViewCell: UITableViewCell {
    @IBOutlet weak var c1_Title: UILabel!
    @IBOutlet weak var c1_confirmed_Total_Amount: UILabel!
    @IBOutlet weak var c1_recovered_Total_Amount: UILabel!
    @IBOutlet weak var c1_deaths_Total_Amount: UILabel!
    
    @IBOutlet weak var c2_Title: UILabel!
    @IBOutlet weak var c2_confirmed_Total_Amount: UILabel!
    @IBOutlet weak var c2_recovered_Total_Amount: UILabel!
    @IBOutlet weak var c2_deaths_Total_Amount: UILabel!
}
