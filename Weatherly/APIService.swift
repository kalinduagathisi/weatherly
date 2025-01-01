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

    func fetchWeather(for location: String) async throws -> WeatherResponse {
        let apiKey = "6b033be26718e9c57182538da3597152"
        let latitude = 33.44 // Replace with dynamic values if needed
        let longitude = -94.04 // Replace with dynamic values if needed
        let urlString = "https://api.openweathermap.org/data/3.0/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 400, userInfo: nil)
        }

        do {
            // Use URLSession's async method
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Decode the JSON response
            let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
            return weatherResponse
        } catch {
            throw error // Propagate the error to the caller
        }
    }
}

