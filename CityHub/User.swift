//
//  User.swift
//  CityHub
//
//  Created by Jack Cook on 03/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import SwiftyJSON

struct User {
    
    var id: Int
    var firstName: String
    var lastName: String
    var anonymous: Bool
    var zipcode: Int
    var languages: [String]
    var email: String
    var uniqueCode: String
    var createdAt: Date
    var updatedAt: Date
    
    init(json: JSON) {
        id = json["id"].int ?? 0
        firstName = json["firstName"].string ?? ""
        lastName = json["lastName"].string ?? ""
        anonymous = json["anonymous"].bool ?? true
        zipcode = json["zipcode"].int ?? 10000
        
        languages = [String]()
        
        if let languages = json["languages"].array {
            for language in languages {
                if let language = language.string {
                    self.languages.append(language)
                }
            }
        }
        
        email = json["email"].string ?? ""
        uniqueCode = json["uniqueCode"].string ?? ""
        createdAt = Date.fromCityHub(json["createdAt"].string)
        updatedAt = Date.fromCityHub(json["updatedAt"].string)
    }
}
