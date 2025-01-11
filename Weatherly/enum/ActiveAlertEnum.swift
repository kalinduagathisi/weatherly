//
//  ActiveAlertEnum.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-11.
//

import Foundation

enum ActiveAlert: Identifiable {
    case cityExists, saveToFavorites, error

    var id: String {
        switch self {
        case .cityExists: return "cityExists"
        case .saveToFavorites: return "saveToFavorites"
        case .error: return "error"
        }
    }
}
