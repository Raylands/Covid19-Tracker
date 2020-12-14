//
//  DetailsCell_CollectionViewCell.swift
//  Covid19-Tracker
//
//  Created by Marco Exner on 08.11.20.
//  Copyright © 2020 Marco Exner. All rights reserved.
//

import UIKit

class DetailsCell_TableViewCell: UITableViewCell {
    @IBOutlet weak var confirmed_Title: UILabel!
    @IBOutlet weak var confirmed_Total_Amount: UILabel!
    @IBOutlet weak var confirmed_Change: UILabel!
    
    @IBOutlet weak var Recovered_Title: UILabel!
    @IBOutlet weak var Recovered_Total_Amount: UILabel!
    @IBOutlet weak var Recovered_Change: UILabel!
    
    @IBOutlet weak var Deaths_Title: UILabel!
    @IBOutlet weak var Deaths_Total_Amount: UILabel!
    @IBOutlet weak var Deaths_Change: UILabel!
}
