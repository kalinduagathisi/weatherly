//
//  WeatherView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2024-12-28.
//

import SwiftData
import SwiftUI

struct WeatherView: View {

    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.modelContext) private var modelContext

    var body: some View {

        ScrollView {
            VStack {
                // search bar
                HStack {
                    TextField("Enter address", text: $viewModel.searchedCity)
                        .padding(.leading, 10)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .submitLabel(.search)
                    // on submit, get weather for searched city
                        .onSubmit {
                            Task {
                                await viewModel.searchWeather(
                                    cityName: viewModel.searchedCity, modelContext: modelContext)
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
                            cityName: viewModel.confirmedCity,
                            currentWeather: currentWeather,
                            dailyWeather: dailyWeather
                        )
                        .padding(.top, 60)
                        .padding(.bottom, 40)
                    }
                }

                // hourly forecast view
                HourlyForecastView(
                    hourlyWeather: viewModel.hourlyWeather,
                    dailyWeather: viewModel.dailyWeather)

                // 5-day forecast view
                DailyForecastView(dailyWeather: viewModel.dailyWeather)

                // air quality view
                if let currentAirQuality = viewModel.airQualityEntry {
                    CurrentAirQualityView(airQualityEntry: currentAirQuality)
                }

                // extra weather details view
                if let currentWeather = viewModel.currentWeather {
                    ExtraWeatherInfoView(currentWeather: currentWeather)
                }

            }
            .padding()
        }
        // When the app appears, fetch weather data for London
        .onAppear {
            Task {
                await viewModel.fetchWeatherForLondon()
            }
        }

        // show alert based in the activeAlert type
        .alert(item: $viewModel.currentAlert) { alert in
            switch alert {
            case .cityExists:
                return Alert(
                    title: Text("City Found"),
                    message: Text(
                        "\(viewModel.searchedCity) is already in the list. Using saved coordinates to fetch data."
                    ),
                    dismissButton: .default(Text("OK"))
                )
            case .saveToFavorites:
                return Alert(
                    title: Text("Save to Favorites?"),
                    message: Text(
                        "Do you want to add \(viewModel.confirmedCity) to your favorites?"
                    ),
                    primaryButton: .default(Text("Yes")) {
                        Task {
                            if let coordinate =
                                try? await viewModel.getCoordinateFrom(
                                    address: viewModel.confirmedCity)
                            {
                                viewModel.saveToFavorites(
                                    cityName: viewModel.confirmedCity,
                                    coordinates: coordinate,
                                    modelContext: modelContext)
                            }
                        }
                    },
                    secondaryButton: .cancel(Text("No"))
                )
            case .error:
                return Alert(
                    title: Text("City Not Found"),
                    message: Text(
                        "We couldn't find weather data for \(viewModel.searchedCity). Please try again."
                    ),
                    dismissButton: .default(Text("OK"))
                )
            }
        }

        // set bg img
        .background(
            Image("bg1")
                .resizable()  // Makes the image resizable
                .scaledToFill()  // Makes sure the image fills the entire area without distortion
                .ignoresSafeArea(edges: .top)
        )

    }

}

#Preview {
    WeatherView()
        .environmentObject(ViewModel())
}
