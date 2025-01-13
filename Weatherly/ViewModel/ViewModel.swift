//
//  WeatherViewModel.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-01.
//

import CoreLocation
import Foundation
import SwiftData

@MainActor
class ViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeather?
    @Published var hourlyWeather: [HourlyWeather] = []
    @Published var dailyWeather: [DailyWeather] = []

    @Published var airQualityEntry: AirQualityEntry?

    @Published var errorMessage: String?

    @Published var coordinate: CLLocationCoordinate2D? = nil
    @Published var geocodingError: Error? = nil

    @Published var searchedCity: String = "London"
    @Published var confirmedCity: String = "London"

    @Published var isWeatherLoaded: Bool = false

    @Published var showSaveAlert: Bool = false
    @Published var showCityExistsAlert: Bool = false
    @Published var showErrorAlert: Bool = false
    @Published var isLoading: Bool = false

    @Published var currentAlert: ActiveAlert?

    @Published var favoriteCities: [City] = []

    private let geocoder = CLGeocoder()

    // add to favourite cities
    func saveToFavorites(
        cityName: String, coordinates: CLLocationCoordinate2D,
        modelContext: ModelContext
    ) {
        // Normalize the city name to lowercase before using it in the predicate
        let normalizedCityName = cityName.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).lowercased()

        // Create a fetch descriptor to look for existing cities with the same normalized name
        let fetchDescriptor = FetchDescriptor<City>(
            predicate: #Predicate { $0.name == normalizedCityName })

        do {
            // Check if the city already exists in the database
            let existingCities = try modelContext.fetch(fetchDescriptor)

            if !existingCities.isEmpty {
                print("City already exists in favorites")
                return
            }

            // Create a new City model
            let city = City(
                name: normalizedCityName,
                latitude: coordinates.latitude,
                longitude: coordinates.longitude,
                showOnPlaceMap: false
            )

            // Add the new city to the SwiftData context
            try modelContext.insert(city)
            print("City saved to favorites: \(cityName)")
        } catch {
            print("Error during saveToFavorites: \(error.localizedDescription)")
        }
    }

    // remove a city from favoriteCities
    func removeCity(_ city: City, modelContext: ModelContext) {
        do {
            // Remove the city from the SwiftData context
            try modelContext.delete(city)

            // Since SwiftData handles state updates for @Query, we no longer need to manually update `favoriteCities`.
            print("City removed: \(city.name)")
        } catch {
            print("Failed to remove city: \(error.localizedDescription)")
        }
    }

    // search weather for any location
    func searchWeather(cityName: String, modelContext: ModelContext) async {
        let normalizedCityName = cityName.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).lowercased()

        do {
            // Check if the city already exists in the database
            let fetchDescriptor = FetchDescriptor<City>(
                predicate: #Predicate { $0.name == normalizedCityName })

            let existingCities = try modelContext.fetch(fetchDescriptor)

            if let existingCity = existingCities.first {
                DispatchQueue.main.async {
                    self.currentAlert = .cityExists
                    print(
                        "City exists alert triggered for: \(existingCity.name)")
                }

                // Use the existing coordinates to fetch data
                await fetchWeather(
                    lat: existingCity.latitude, lon: existingCity.longitude
                )
                await fetchAirQuality(
                    lat: existingCity.latitude, lon: existingCity.longitude
                )

                DispatchQueue.main.async {
                    self.confirmedCity = existingCity.name
                }
                return
            }

            // Get coordinates for the searched address
            let coordinate = try await getCoordinateFrom(address: searchedCity)

            // Fetch weather data for the new location
            await fetchWeather(
                lat: coordinate.latitude, lon: coordinate.longitude)
            await fetchAirQuality(
                lat: coordinate.latitude, lon: coordinate.longitude)

            // Update the shared property and alert
            DispatchQueue.main.async {
                self.confirmedCity = cityName
                self.currentAlert = .saveToFavorites
            }
        } catch {
            DispatchQueue.main.async {
                self.currentAlert = .error
            }
            print("Search failed: \(error.localizedDescription)")
        }
    }

    // fetch weather for London
    func fetchWeatherForLondon() async {
        guard !isWeatherLoaded else { return }  // Prevent refetching
        do {
            let coordinate = try await getCoordinateFrom(address: "London")
            await fetchWeather(
                lat: coordinate.latitude, lon: coordinate.longitude)
            await fetchAirQuality(
                lat: coordinate.latitude, lon: coordinate.longitude)
            DispatchQueue.main.async {
                self.isWeatherLoaded = true
            }
        } catch {
            print("Geocoding failed for London: \(error.localizedDescription)")
        }
    }

    // Fetch weather data for given latitude and longitude
    func fetchWeather(lat: Double, lon: Double) async {
        self.isLoading = true
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
        self.isLoading = false
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

    // Helper function to format date from UNIX timestamp
    func formatDate(_ dt: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"  // Example: Mon, Tue
        return formatter.string(from: date)
    }

    // Helper function to map weather condition to SF Symbols
    func weatherIcon(for condition: String) -> String {
        switch condition.lowercased() {
        case "clear":
            return "sun.max.fill"
        case "clouds":
            return "cloud.fill"
        case "rain":
            return "cloud.rain.fill"
        case "snow":
            return "cloud.snow.fill"
        case "thunderstorm":
            return "cloud.bolt.fill"
        case "drizzle":
            return "cloud.drizzle.fill"
        default:
            return "cloud.fill"
        }
    }

    // Helper function to calculate progress for the temperature bar
    func progressValue(minTemp: Double, maxTemp: Double) -> Double {
        let range = maxTemp - minTemp
        return range > 0 ? (maxTemp - minTemp) / range : 0.5
    }

}
