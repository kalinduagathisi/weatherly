//
//  WeatherViewModel.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-01.
//

import Foundation
import CoreLocation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeather?
    @Published var hourlyWeather: [HourlyWeather] = []
    @Published var dailyWeather: [DailyWeather] = []
    @Published var errorMessage: String?
    
    @Published var coordinate: CLLocationCoordinate2D? = nil
    @Published var geocodingError: Error? = nil
    
    private let geocoder = CLGeocoder()

    // Fetch weather data for given latitude and longitude
    func fetchWeather(lat: Double, lon: Double) async {
        do {
            // Call the async API method with latitude and longitude
            let weatherResponse = try await APIService.shared.fetchWeather(lat: lat, lon: lon)
            
            // Update published properties on the main thread
            self.currentWeather = weatherResponse.current
            self.hourlyWeather = weatherResponse.hourly
            self.dailyWeather = weatherResponse.daily
            self.errorMessage = nil // Clear any previous error
        } catch {
            // Handle and publish the error
            self.errorMessage = error.localizedDescription
        }
    }

    
    // fetch geo coordinates
    func getCoordinateFrom(address: String) async throws -> CLLocationCoordinate2D {
        try await withCheckedThrowingContinuation { continuation in
            geocoder.geocodeAddressString(address) { placemarks, error in
                DispatchQueue.main.async {
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let coordinate = placemarks?.first?.location?.coordinate {
                        continuation.resume(returning: coordinate)
                    } else {
                        continuation.resume(throwing: NSError(
                            domain: "GeocodingError",
                            code: 0,
                            userInfo: [NSLocalizedDescriptionKey: "No coordinates found for the given address."]
                        ))
                    }
                }
            }
        }
    }

    
    // convert K to f
    func kelvinToFahrenheit(kelvin: Double) -> Double {
        return (kelvin - 273.15) * 9/5 + 32
    }

}


