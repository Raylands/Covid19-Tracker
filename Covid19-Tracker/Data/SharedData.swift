//
//  Covid_Data.swift
//  Covid19-Tracker
//
//  Created by Marco Exner on 18.11.20.
//  Copyright © 2020 Marco Exner. All rights reserved.
//

import Foundation
import UIKit

struct SharedData{
    static var Covid_cases_all: [Covid_Data_new] = []
    static var Covid_cases_all_day_before: [Covid_Data_new] = []
    static var Covid_cases: [Covid_Data_new] = []
    static var CurrentCountry: Int?
    static var CompareCountry: Int?
    static var initialized_data: Bool = false
    static var flags = [String: UIImage]()
}
