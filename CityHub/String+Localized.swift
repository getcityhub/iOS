//
//  String+Localized.swift
//  CityHub
//
//  Created by Jack Cook on 12/02/2017.
//  Copyright © 2017 CityHub. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
