//
//  AirQualityModel.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-02.
//

import Foundation

// MARK: - AirQualityData
struct AirQualityDataResponse: Codable {
    let coord: Coordinate
    let list: [AirQualityEntry]
}

// MARK: - Coordinate
struct Coordinate: Codable {
    let lon: Double
    let lat: Double
}

// MARK: - AirQualityEntry
struct AirQualityEntry: Codable {
    let main: AQIMain
    let components: AirComponents
    let dt: Int
}

// MARK: - AQIMain
struct AQIMain: Codable {
    let aqi: Int // Air Quality Index (1 to 5)
}

// MARK: - AirComponents
struct AirComponents: Codable {
    let co: Double // Carbon Monoxide (µg/m³)
    let no: Double // Nitrogen Monoxide (µg/m³)
    let no2: Double // Nitrogen Dioxide (µg/m³)
    let o3: Double // Ozone (µg/m³)
    let so2: Double // Sulfur Dioxide (µg/m³)
    let pm2_5: Double // Particulate Matter 2.5 (µg/m³)
    let pm10: Double // Particulate Matter 10 (µg/m³)
    let nh3: Double // Ammonia (µg/m³)
}

