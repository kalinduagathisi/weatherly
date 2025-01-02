//
//  WeatherView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2024-12-28.
//

import SwiftUI

struct WeatherView: View {

    @StateObject var viewModel = WeatherViewModel()
    @State var address: String = "London"

    var body: some View {

        ScrollView {

            VStack {

                // search bar
                HStack {
                    TextField("Enter address", text: $address)
                        .padding(.leading, 10)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .submitLabel(.search)  // This will make the return key appear as "Search"
                        .onSubmit {
                            Task {
                                await searchWeather()
                            }
                        }

                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.trailing, 10)
                }
                .padding()
                .frame(height: 45)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white.opacity(0.8))
                        .shadow(
                            color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                )
                .padding(.horizontal, 20)

                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {

                    if let currentWeather = viewModel.currentWeather,
                        let dailyWeather = viewModel.dailyWeather.first
                    {
                        // weather summery view
                        WeatherSummeryView(
                            cityName: address,
                            currentWeather: currentWeather,
                            dailyWeather: dailyWeather
                        )
                        .padding(.top, 60)
                        .padding(.bottom, 40)
                    }
                }

                // hourly forecast view
                HourlyForecastView(hourlyWeather: viewModel.hourlyWeather)

                // 5-day forecast view
                DailyForecastView(dailyWeather: viewModel.dailyWeather)

                // air quality view
                if let currentAirQuality = viewModel.airQualityEntry {
                    CurrentAirQualityView(airQualityEntry: currentAirQuality)
                }

            }
            .padding()
        }
        .onAppear {
            // When the app appears, fetch weather data for London
            Task {
                await fetchWeatherForLondon()
            }
        }

        // Set sky gradient background
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.blue, Color.blue.opacity(0.7),
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }

    // Fetch weather data for London
    private func fetchWeatherForLondon() async {
        do {
            // Get coordinates for London
            let coordinate = try await viewModel.getCoordinateFrom(
                address: "London")

            // Fetch weather data for London
            await viewModel.fetchWeather(
                lat: coordinate.latitude, lon: coordinate.longitude)
            
            await viewModel.fetchAirQuality(
                lat: coordinate.latitude, lon: coordinate.longitude)
        } catch {
            print("Geocoding failed for London: \(error.localizedDescription)")
        }
    }

    // Helper method to handle async weather search for a specific address
    private func searchWeather() async {
        do {
            // Get coordinates for the searched address
            let coordinate = try await viewModel.getCoordinateFrom(
                address: address)

            // Fetch weather data using the obtained coordinates
            await viewModel.fetchWeather(
                lat: coordinate.latitude, lon: coordinate.longitude)
            
            await viewModel.fetchAirQuality(
                lat: coordinate.latitude, lon: coordinate.longitude)
        } catch {
            print("Geocoding failed: \(error.localizedDescription)")
        }
    }

}

#Preview {
    WeatherView()
}
