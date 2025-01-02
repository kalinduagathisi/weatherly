//
//  WeatherViewModel.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-01.
//

import CoreLocation
import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeather?
    @Published var hourlyWeather: [HourlyWeather] = []
    @Published var dailyWeather: [DailyWeather] = []

    @Published var airQualityEntry: AirQualityEntry?

    @Published var errorMessage: String?

    @Published var coordinate: CLLocationCoordinate2D? = nil
    @Published var geocodingError: Error? = nil

    private let geocoder = CLGeocoder()

    // Fetch weather data for given latitude and longitude
    func fetchWeather(lat: Double, lon: Double) async {
        do {
            // Call the async API method with latitude and longitude
            let weatherResponse = try await APIService.shared.fetchWeather(
                lat: lat, lon: lon)

            // Update published properties on the main thread
            self.currentWeather = weatherResponse.current
            self.hourlyWeather = weatherResponse.hourly
            self.dailyWeather = weatherResponse.daily
            self.errorMessage = nil  // Clear any previous error
        } catch {
            // Handle and publish the error
            self.errorMessage = error.localizedDescription
        }
    }

    // fetch air quality data
    func fetchAirQuality(lat: Double, lon: Double) async {
        do {
            // Call the async API method with latitude and longitude
            let airQualityResponse = try await APIService.shared
                .fetchAirQualityData(lat: lat, lon: lon)

            // Check if the list has at least one entry
            if let firstEntry = airQualityResponse.list.first {
                DispatchQueue.main.async {
                    self.airQualityEntry = firstEntry
                    self.errorMessage = nil  // Clear any previous error
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "No air quality data available."
                }
            }
        } catch {
            // Handle and publish the error on the main thread
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }

    // fetch geo coordinates
    func getCoordinateFrom(address: String) async throws
        -> CLLocationCoordinate2D
    {
        try await withCheckedThrowingContinuation { continuation in
            geocoder.geocodeAddressString(address) { placemarks, error in
                DispatchQueue.main.async {
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let coordinate = placemarks?.first?.location?
                        .coordinate
                    {
                        continuation.resume(returning: coordinate)
                    } else {
                        continuation.resume(
                            throwing: NSError(
                                domain: "GeocodingError",
                                code: 0,
                                userInfo: [
                                    NSLocalizedDescriptionKey:
                                        "No coordinates found for the given address."
                                ]
                            ))
                    }
                }
            }
        }
    }

    // convert K to f
    func kelvinToFahrenheit(kelvin: Double) -> Double {
        return (kelvin - 273.15) * 9 / 5 + 32
    }

    // Helper to format the hour
    func formattedHour(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"  // e.g., "1 PM"
        return formatter.string(from: date)
    }

}
