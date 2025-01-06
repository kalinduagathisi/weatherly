//
//  APIService.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-01.
//

import Foundation

class APIService {
    static let shared = APIService()
    private init() {}

    // fetch weather data
    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherResponse {
        let apiKey = Config.apiKey // Fetch API key dynamically
        let urlString = "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=\(apiKey)"
        
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 400, userInfo: nil)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(WeatherResponse.self, from: data)
    }
    
    // fetch air quality data
    func fetchAirQualityData(lat: Double, lon: Double) async throws -> AirQualityDataResponse {
        let apiKey = Config.apiKey
        let urlString = "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&units=metric&appid=\(apiKey)"
        
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 400, userInfo: nil)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(AirQualityDataResponse.self, from: data)
    }
}


