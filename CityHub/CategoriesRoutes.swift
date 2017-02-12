//
//  CategoriesRoutes.swift
//  CityHub
//
//  Created by Jack Cook on 12/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import SwiftyJSON

class CategoriesRoutes {
    
    func getCategories(completion: ((_ categories: [Category]?, _ error: CityHubRequestError?) -> Void)?) {
        CityHubRequest.request("/categories") { json, error in
            guard let categories = json?.array else {
                completion?(nil, error)
                return
            }
            
            var retrievedCategories = [Category]()
            
            for category in categories {
                let retrievedCategory = Category(json: category)
                retrievedCategories.append(retrievedCategory)
            }
            
            completion?(retrievedCategories, error)
        }
    }
}
