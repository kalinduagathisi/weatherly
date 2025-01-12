//
//  LocationModel.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-02.
//

import Foundation
import SwiftData

@Model
final class City {
    @Attribute(.unique) var name: String
    var latitude: Double
    var longitude: Double
    var showOnPlaceMap: Bool

    init(
        name: String, latitude: Double, longitude: Double, showOnPlaceMap: Bool
    ) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.showOnPlaceMap = showOnPlaceMap
    }
}
