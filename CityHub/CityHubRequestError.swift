//
//  CityHubRequestError.swift
//  CityHub
//
//  Created by Jack Cook on 02/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import SwiftyJSON

enum CityHubRequestError: Equatable, Error {
    case badRequest(message: String),
    unauthorized,
    accessDenied,
    notFound
    
    case shortFirstName,
    longFirstName,
    invalidFirstName,
    shortLastName,
    longLastName,
    invalidLastName,
    invalidZipcode,
    weakPassword,
    invalidEmail,
    usedEmail
    
    case offline
    
    case unknown(data: JSON?)
    
    func getUserMessage() -> String {
        let english: () -> String = {
            switch self {
            case .unauthorized: return "Incorrect email address or password"
            case .shortFirstName: return "First name is too short"
            case .longFirstName: return "First name is too long"
            case .invalidFirstName: return "First name can only contain letters"
            case .shortLastName: return "Last name is too short"
            case .longLastName: return "Last name is too long"
            case .invalidLastName: return "Last name can only contain letters"
            case .invalidZipcode: return "Zipcode is not a valid NYC zipcode"
            case .weakPassword: return "Password is too weak"
            case .invalidEmail: return "Email address is invalid"
            case .usedEmail: return "Email address has already been registered"
            default: return "An unknown error occurred"
            }
        }
        
        return english().localized
    }
}

func ==(lhs: CityHubRequestError, rhs: CityHubRequestError) -> Bool {
    switch (lhs, rhs) {
    case (.badRequest(_), .badRequest(_)): return true
    case (.unauthorized, .unauthorized): return true
    case (.accessDenied, .accessDenied): return true
    case (.notFound, .notFound): return true
    case (.offline, .offline): return true
    case (.unknown(_), .unknown(_)): return true
    default: return false
    }
}
