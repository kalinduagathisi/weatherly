//
//  LocationModel.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-02.
//

import Foundation

struct City: Identifiable, Codable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
}


