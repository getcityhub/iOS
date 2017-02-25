//
//  Language.swift
//  CityHub
//
//  Created by Jack Cook on 2/25/17.
//  Copyright © 2017 CityHub. All rights reserved.
//

import Foundation

enum Language: String {
    case english = "en-US"
    case spanish = "es-ES"
    case french = "fr-FR"
    case simplified = "zh-Hans"
    case traditional = "zh-Hant"
    
    static var current: Language {
        for code in NSLocale.preferredLanguages {
            let regexes: [String: Language] = [
                "en(.*)?": .english,
                "es(.*)?": .spanish,
                "fr(.*)?": .french,
                "zh-Hans(.*)?": .simplified,
                "zh-Hant(.*)?": .traditional
            ]
            
            for (pattern, language) in regexes {
                do {
                    let regex = try NSRegularExpression(pattern: pattern, options: [])
                    
                    if regex.matches(in: code, options: [], range: NSRange(location: 0, length: code.characters.count)).count > 0 {
                        return language
                    }
                } catch {
                    continue
                }
            }
        }
        
        return .english
    }
}
