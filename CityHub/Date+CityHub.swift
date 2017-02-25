//
//  Date+CityHub.swift
//  CityHub
//
//  Created by Jack Cook on 12/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import Foundation

extension Date {
    
    public static func fromCityHub(_ dateString: String?) -> Date {
        guard let string = dateString else {
            return Date(timeIntervalSince1970: 0)
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.date(from: string) ?? Date(timeIntervalSince1970: 0)
    }
}
