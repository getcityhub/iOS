//
//  CityHubClient.swift
//  CityHub
//
//  Created by Jack Cook on 12/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

class CityHubClient {
    
    public class var shared: CityHubClient {
        struct Static {
            static let instance = CityHubClient()
        }
        return Static.instance
    }
    
    public let categories: CategoriesRoutes
    
    private init() {
        categories = CategoriesRoutes()
    }
}
