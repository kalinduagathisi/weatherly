//
//  Config.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-06.
//

import Foundation

struct Config {
    static var apiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "APIKey") as? String else {
            fatalError("API Key not found in Info.plist")
        }
        return key
    }
}

