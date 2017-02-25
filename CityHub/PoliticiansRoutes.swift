//
//  PoliticiansRoutes.swift
//  CityHub
//
//  Created by Jack Cook on 2/18/17.
//  Copyright © 2017 CityHub. All rights reserved.
//

import SwiftyJSON

class PoliticiansRoutes {
    
    func getPoliticians(zipcode: String?, completion: ((_ politicians: [Politician]?, _ error: CityHubRequestError?) -> Void)?) {
        var params = [String: String]()
        
        if let zipcode = zipcode {
            params["zip"] = zipcode
            params["lang"] = Language.current.rawValue
        }
        
        CityHubRequest.request("/politicians", params: params) { json, error in
            guard let politicians = json?.array else {
                completion?(nil, error)
                return
            }
            
            var retrievedPoliticians = [Politician]()
            
            for politician in politicians {
                let retrievedPolitician = Politician(json: politician)
                retrievedPoliticians.append(retrievedPolitician)
            }
            
            completion?(retrievedPoliticians, error)
        }
    }
}
