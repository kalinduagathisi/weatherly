//
//  WeatherViewModel.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-01.
//

import CoreLocation
import Foundation

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

    @Published var selectedCities: Set<City> = []

    @Published var showSaveAlert: Bool = false
    @Published var showCityExistsAlert: Bool = false
    @Published var showErrorAlert: Bool = false
    @Published var isLoading: Bool = false

    @Published var currentAlert: ActiveAlert?

    @Published var favoriteCities: [City] = [
        City(
            id: UUID(), name: "New York", latitude: 40.7128, longitude: -74.0060
        ),
        City(
            id: UUID(), name: "Los Angeles", latitude: 34.0522,
            longitude: -118.2437),
        City(
            id: UUID(), name: "Chicago", latitude: 41.8781, longitude: -87.6298),
    ]

    private let geocoder = CLGeocoder()

    // add to favourite cities
    func saveToFavorites(cityName: String, coordinates: CLLocationCoordinate2D)
    {
        let city = City(
            id: UUID(),
            name: cityName,
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
        if !favoriteCities.contains(where: { $0.name == city.name }) {
            favoriteCities.append(city)
        }
    }

    // remove a city from favoriteCities
    func removeCity(_ city: City) {
        if let index = favoriteCities.firstIndex(where: { $0.id == city.id }) {

            // remove from fav cities
            favoriteCities.remove(at: index)

            // Remove from selectedCities
            selectedCities.remove(city)
        }
    }

    // search weather for any location
    func searchWeather(cityName: String) async {

        let normalizedCityName = cityName.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).lowercased()

        // Check if the city is already in favoriteCities
        if let existingCity = favoriteCities.first(where: {
            $0.name.lowercased() == normalizedCityName
        }) {
            DispatchQueue.main.async {
                self.currentAlert = .cityExists
                print("City exists alert triggered for: \(existingCity.name)")
            }

            // Use the existing coordinates to fetch data
            await fetchWeather(
                lat: existingCity.latitude, lon: existingCity.longitude)
            await fetchAirQuality(
                lat: existingCity.latitude, lon: existingCity.longitude)

            DispatchQueue.main.async {
                self.confirmedCity = existingCity.name
            }
            return
        }

        do {
            // Get coordinates for the searched address
            let coordinate = try await getCoordinateFrom(
                address: searchedCity)

            // call fetchWeather()
            await fetchWeather(
                lat: coordinate.latitude, lon: coordinate.longitude)

            // call fetchAirQuality()
            await fetchAirQuality(
                lat: coordinate.latitude, lon: coordinate.longitude)

            // Update the shared property
            DispatchQueue.main.async {
                self.confirmedCity = cityName
                if !self.favoriteCities.contains(where: { $0.name == cityName })
                {
                    self.currentAlert = .saveToFavorites
                }

            }
        } catch {
            DispatchQueue.main.async {
                self.currentAlert = .error
            }
            print("Geocoding failed: \(error.localizedDescription)")
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

}
