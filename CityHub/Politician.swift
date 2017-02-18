//
//  Politician.swift
//  CityHub
//
//  Created by Jack Cook on 2/18/17.
//  Copyright © 2017 CityHub. All rights reserved.
//

import SwiftyJSON

struct Politician {
    
    var id: Int
    var name: String
    var zipcodes: [Int]
    var position: String
    var party: String
    var email: String
    var phone: String
    var website: String
    var facebook: String
    var googleplus: String
    var twitter: String
    var youtube: String
    var createdAt: Date
    var updatedAt: Date
    
    init(json: JSON) {
        id = json["id"].int ?? 0
        name = json["name"].string ?? ""
        
        zipcodes = [Int]()
        
        if let zipcodes = json["zipcodes"].array {
            for zipcode in zipcodes {
                if let zipcode = zipcode.int {
                    self.zipcodes.append(zipcode)
                }
            }
        }
        
        position = json["position"].string ?? ""
        party = json["party"].string ?? ""
        email = json["email"].string ?? ""
        phone = json["phone"].string ?? ""
        website = json["website"].string ?? ""
        facebook = json["facebook"].string ?? ""
        googleplus = json["googleplus"].string ?? ""
        twitter = json["twitter"].string ?? ""
        youtube = json["youtube"].string ?? ""
        createdAt = Date.fromCityHub(json["createdAt"].string)
        updatedAt = Date.fromCityHub(json["updatedAt"].string)
    }
}
