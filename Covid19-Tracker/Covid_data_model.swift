//
//  Covid_data_model.swift
//  Covid19-Tracker
//
//  Created by Marco Exner on 07.10.20.
//  Copyright © 2020 Marco Exner. All rights reserved.
//

import Foundation

enum APIError:String, Error {
    case invalidURL
    case noDataReceived
    case notAbletoUnpack
}

struct Covid_Data: Codable {
    var country: String
    var confirmed: Int32
    var recovered: Int32
    var critical: Int32
    var deaths: Int32
    //var lastChange: String //TODO: Fix Data type
    //var lastUpdate: String
}



func getData(url: String, completiton: @escaping(Result<[Covid_Data],APIError>) -> Void ) {
    guard let url_tmp = URL.init(string: url) else {
        completiton(.failure(.invalidURL))
        return
    }
    URLSession.shared.dataTask(with: url_tmp) {data, _, _ in
        guard let jsonData = data else {
            completiton(.failure(.noDataReceived))
            return
        }
        do{
            let response = try JSONDecoder().decode([Covid_Data].self, from: jsonData)
            completiton(.success(response))
        } catch {
            completiton(.failure(.notAbletoUnpack))
        }
        
    }.resume()
}

/*
 {
   "country": "Afghanistan",
   "code": "AF",
   "confirmed": 39548,
   "recovered": 33045,
   "critical": 93,
   "deaths": 1469,
   "latitude": 33.93911,
   "longitude": 67.709953,
   "lastChange": "2020-10-07T08:15:37+02:00",
   "lastUpdate": "2020-10-07T12:15:03+02:00"
 },
 {
   "country": "Åland Islands",
   "code": "AX",
   "confirmed": 0,
   "recovered": 0,
   "critical": 0,
   "deaths": 0,
   "latitude": 60.1995487,
   "longitude": 20.3711715,
   "lastChange": null,
   "lastUpdate": null
 },
 {
   "country": "Albania",
   "code": "AL",
   "confirmed": 14568,
   "recovered": 8965,
   "critical": 23,
   "deaths": 403,
   "latitude": 41.153332,
   "longitude": 20.168331,
   "lastChange": "2020-10-06T17:28:24+02:00",
   "lastUpdate": "2020-10-07T12:15:03+02:00"
 },
 */
