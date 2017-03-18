//
//  UsersRoutes.swift
//  CityHub
//
//  Created by Jack Cook on 2/18/17.
//  Copyright © 2017 CityHub. All rights reserved.
//

import SwiftyJSON

class UsersRoutes {
    
    func login(email: String, password: String, completion: ((_ user: User?, _ error: CityHubRequestError?) -> Void)?) {
        let body = [
            "email": email,
            "password": password
        ] as [String: Any]
        
        CityHubRequest.request("/users/login", requestType: "POST", body: body) { json, error in
            guard let json = json else {
                completion?(nil, error)
                return
            }
            
            let user = User(json: json)
            completion?(user, error)
        }
    }
    
    func register(firstName: String, lastName: String, anonymous: Bool, zipcode: String, languages: [String], email: String, password: String, completion: ((_ user: User?, _ error: CityHubRequestError?) -> Void)?) {
        let body = [
            "firstName": firstName,
            "lastName": lastName,
            "anonymous": anonymous,
            "zipcode": zipcode,
            "languages": languages,
            "email": email,
            "password": password
        ] as [String: Any]
        
        CityHubRequest.request("/users", requestType: "POST", body: body) { json, error in
            guard let json = json else {
                completion?(nil, error)
                return
            }
            
            let user = User(json: json)
            completion?(user, error)
        }
    }
    
    func resetPassword(email: String, completion: ((_ error: CityHubRequestError?) -> Void)?) {
        let body = [
            "email": email
        ] as [String: Any]
        
        CityHubRequest.request("/users/reset", requestType: "POST", body: body) { json, error in
            completion?(error)
        }
    }
}
