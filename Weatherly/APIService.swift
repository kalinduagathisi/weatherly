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

    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherResponse {
        let apiKey = "6b033be26718e9c57182538da3597152"
        let urlString = "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=\(apiKey)"
        
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 400, userInfo: nil)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(WeatherResponse.self, from: data)
    }
}


