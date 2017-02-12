//
//  Category.swift
//  CityHub
//
//  Created by Jack Cook on 12/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import SwiftyJSON

struct Category {
    var id: Int
    var name: String
    
    init(json: JSON) {
        id = json["id"].int ?? 0
        name = json["name"].string ?? ""
    }
}
