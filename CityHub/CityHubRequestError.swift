//
//  CityHubRequestError.swift
//  CityHub
//
//  Created by Jack Cook on 02/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import SwiftyJSON

enum CityHubRequestError: Equatable, Error {
    case badRequest(data: JSON?),
    unauthorized,
    accessDenied,
    notFound
    
    case offline
    
    case unknown(data: JSON?)
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
