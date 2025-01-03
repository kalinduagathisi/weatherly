//
//  LocationModel.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-02.
//

import Foundation

struct City: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let latitude: Double
    let longitude: Double

    // Hashable and Equatable are synthesized automatically because all properties are Hashable.
}




