//
//  User.swift
//  CityHub
//
//  Created by Jack Cook on 03/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import Foundation

struct User {
    var id: Int
    var firstName: String
    var lastName: String
    var anonymous: Bool
    var languages: [String]
    var topics: [String]
    var uniqueCode: String
    var createdAt: Date
    var updatedAt: Date
}
