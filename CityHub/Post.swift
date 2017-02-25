//
//  Post.swift
//  CityHub
//
//  Created by Jack Cook on 02/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import SwiftyJSON

struct Post {
    
    var id: Int
    var title: String
    var authorId: Int
    var author: User
    var categoryId: Int
    var text: String
    var language: String
    var createdAt: Date
    var updatedAt: Date
    
    init(json: JSON) {
        id = json["id"].int ?? 0
        title = json["title"].string ?? ""
        authorId = json["authorId"].int ?? 0
        author = User(json: json["author"])
        categoryId = json["categoryId"].int ?? 0
        text = json["text"].string ?? ""
        language = json["language"].string ?? ""
        createdAt = Date.fromCityHub(json["createdAt"].string)
        updatedAt = Date.fromCityHub(json["updatedAt"].string)
    }
}
