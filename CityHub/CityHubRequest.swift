//
//  CityHubRequest.swift
//  CityHub
//
//  Created by Jack Cook on 02/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import Foundation
import SwiftyJSON

class CityHubRequest {
    
    private static var baseURL = "http://localhost:4567"
    
    class func request(_ endpoint: String, requestType: String = "GET", headers: [String: String] = [String: String](), params: [String: String] = [String: String](), body: Any? = nil, completion: ((_ json: JSON?, _ error: CityHubRequestError?) -> Void)?) {
        CityHubRequest.dataRequest("\(baseURL)\(endpoint)", requestType: requestType, headers: headers, params: params, body: body) { (data, error) in
            guard let data = data else {
                completion?(nil, error)
                return
            }
            
            let json = JSON(data: data)
            completion?(json, error)
        }
    }
    
    class func dataRequest(_ baseURL: String, requestType: String = "GET", headers: [String: String] = [String: String](), params: [String: String] = [String: String](), body: Any? = nil, completion: ((_ data: Data?, _ error: CityHubRequestError?) -> Void)?) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        var url = URL(string: baseURL)!
        url = URLByAppendingQueryParameters(url, queryParameters: params)
        
        var request = URLRequest(url: url)
        request.httpMethod = requestType
        
        if let body = body {
            do {
                request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                completion?(nil, .badRequest(message: "An unknown error occurred"))
                return
            }
        }
        
        request.addValue(Language.current.rawValue, forHTTPHeaderField: "Accept-Language")
        
        for (header, val) in headers {
            request.addValue(val, forHTTPHeaderField: header)
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, let data = data else {
                completion?(nil, .unknown(data: nil))
                return
            }
            
            let json = JSON(data: data)
            var requestError: CityHubRequestError = .unknown(data: json)
            
            if let error = error {
                switch error._code {
                case -1009: requestError = .offline
                default: break
                }
                
                completion?(nil, requestError)
            } else if response.statusCode != 200 && response.statusCode != 204 {
                switch response.statusCode {
                case 400:
                    if let message = json["message"].string {
                        if message == "First name must be at least two characters long." {
                            requestError = .shortFirstName
                        } else if message == "First name must be at most 20 characters long." {
                            requestError = .longFirstName
                        } else if message == "First name must only have letters." {
                            requestError = .invalidFirstName
                        } else if message == "Last name must be at least two characters long." {
                            requestError = .shortLastName
                        } else if message == "Last name must be at most 20 characters long." {
                            requestError = .longLastName
                        } else if message == "Last name must only have letters." {
                            requestError = .invalidLastName
                        } else if message == "Zipcode must be a valid NYC zipcode." {
                            requestError = .invalidZipcode
                        } else if message.contains("Password is too weak.") {
                            requestError = .weakPassword
                        } else if message == "Email address is invalid." {
                            requestError = .invalidEmail
                        } else if message == "Email address has already been registered." {
                            requestError = .usedEmail
                        } else {
                            requestError = .badRequest(message: message)
                        }
                    } else {
                        requestError = .badRequest(message: json["message"].string ?? "An unknown error occurred.")
                    }
                case 401: requestError = .unauthorized
                case 403: requestError = .accessDenied
                case 404: requestError = .notFound
                default:
                    print("Unknown status code: \(response.statusCode)")
                    requestError = .unknown(data: json)
                }
                
                completion?(data, requestError)
            } else {
                completion?(data, nil)
            }
        }
        
        task.resume()
    }
    
    fileprivate class func stringFromQueryParameters(_ queryParameters: [String: String]) -> String {
        var parts = [String]()
        for (name, value) in queryParameters {
            let part = NSString(format: "%@=%@",
                                name.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!,
                                value.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
    fileprivate class func URLByAppendingQueryParameters(_ url: URL!, queryParameters: [String: String]) -> URL {
        let URLString = NSString(format: "%@?%@", url.absoluteString, stringFromQueryParameters(queryParameters))
        return URL(string: URLString as String)!
    }
}
