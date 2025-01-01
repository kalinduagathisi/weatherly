//
//  WeatherViewModel.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-01.
//

import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeather?
    @Published var hourlyWeather: [HourlyWeather] = []
    @Published var dailyWeather: [DailyWeather] = []
    @Published var dailyTemperature: DailyTemperature?
    @Published var errorMessage: String?

    func fetchWeather(for location: String) async {
        do {
            // Call the async API method
            let weatherResponse = try await APIService.shared.fetchWeather(for: location)
            
            // Update published properties on the main thread
            self.currentWeather = weatherResponse.current
            self.hourlyWeather = weatherResponse.hourly
            self.dailyWeather = weatherResponse.daily
            self.dailyTemperature = weatherResponse.dailyTemp
            self.errorMessage = nil // Clear any previous error
        } catch {
            // Handle and publish the error
            self.errorMessage = error.localizedDescription
        }
    }
}


