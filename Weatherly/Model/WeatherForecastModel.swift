//
//  WeatherForecastModel.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-01.
//

import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: CurrentWeather
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]
    
    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, hourly, daily
    }
}

// MARK: - Current Weather
struct CurrentWeather: Codable {
    let dt: Int
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let wind_speed: Double
    let wind_deg: Double
    let dew_point: Double
    let uvi: Double
    let weather: [WeatherDetail]
    
    enum CodingKeys: String, CodingKey {
        case dt, temp, pressure, humidity, weather, wind_speed, wind_deg, dew_point, uvi
        case feelsLike = "feels_like"
    }
}

// MARK: - Hourly Weather
struct HourlyWeather: Codable {
    let dt: Int
    let temp: Double
    let weather: [WeatherDetail]
}

// MARK: - Daily Weather
struct DailyWeather: Codable {
    let dt: Int
    let temp: DailyTemperature
    let summary: String
    let weather: [WeatherDetail]
}

// MARK: - Weather Details
struct WeatherDetail: Codable {
    let main: String
    let description: String
    let icon: String
}

// MARK: - Temperature
struct DailyTemperature: Codable {
    let day: Double
    let min: Double
    let max: Double
}


//// MARK: - Alerts
//struct WeatherAlert: Codable {
//    let senderName: String
//    let event: String
//    let description: String
//    
//    enum CodingKeys: String, CodingKey {
//        case senderName = "sender_name"
//        case event, description
//    }
//}
