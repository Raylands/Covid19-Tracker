//
//  Covid_Data.swift
//  Covid19-Tracker
//
//  Created by Marco Exner on 18.11.20.
//  Copyright © 2020 Marco Exner. All rights reserved.
//

import Foundation

struct SharedData{
    static var Covid_cases_all: [Covid_Data] = []
    static var Covid_cases: [Covid_Data] = []
    static var CurrentCountry: String?
}
