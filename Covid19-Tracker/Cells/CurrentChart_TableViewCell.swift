//
//  CurrentChart_CollectionViewCell.swift
//  Covid19-Tracker
//
//  Created by Marco Exner on 06.12.20.
//  Copyright © 2020 Marco Exner. All rights reserved.
//

import UIKit
import Charts

class CurrentChart_TableViewCell: UITableViewCell {
    @IBOutlet weak var current_pichart: PieChartView!
    @IBOutlet weak var noteModificationTimeLabel: UILabel!
}
