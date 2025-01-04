//
//  WeatherView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2024-12-28.
//

import SwiftUI

struct WeatherView: View {

    @EnvironmentObject var viewModel: ViewModel
    //    @StateObject var viewModel = WeatherViewModel()
    //    @State var address: String = "Colombo"

    var body: some View {

        ScrollView {

            VStack {

                // search bar
                HStack {
                    TextField("Enter address", text: $viewModel.searchedCity)
                        .padding(.leading, 10)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .submitLabel(.search)  // This will make the return key appear as "Search"
                        .onSubmit {
                            Task {
                                //                                await searchWeather()
                                await viewModel.searchWeather(
                                    cityName: viewModel.searchedCity)
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
                HourlyForecastView(hourlyWeather: viewModel.hourlyWeather)

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
        .onAppear {
            // When the app appears, fetch weather data for London
            Task {
                await viewModel.fetchWeatherForLondon()
            }
        }
        .alert("Save to Favorites?", isPresented: $viewModel.showSaveAlert) {
            Button("Yes") {
                Task {
                    if let coordinate = try? await viewModel.getCoordinateFrom(
                        address: viewModel.confirmedCity)
                    {
                        viewModel.saveToFavorites(
                            cityName: viewModel.confirmedCity,
                            coordinates: coordinate)
                    }
                }
            }
            Button("No", role: .cancel) {}
        } message: {
            Text(
                "Do you want to add \(viewModel.confirmedCity) to your favorites?"
            )
        }
        
        .alert(isPresented: $viewModel.showErrorAlert) {
            Alert(
                title: Text("City Not Found"),
                message: Text("We couldn't find weather data for \(viewModel.searchedCity). Please try again."),
                dismissButton: .default(Text("OK"))
            )
        }
        
        .background(
            Image("bg3")
                .resizable() // Makes the image resizable
                .scaledToFill() // Makes sure the image fills the entire area without distortion
                .ignoresSafeArea() // Ensures the image covers the whole screen
        )

//        // Set sky gradient background
//        .background(
//            LinearGradient(
//                gradient: Gradient(colors: [
//                    Color.blue, Color.blue.opacity(0.7),
//                ]),
//                startPoint: .top,
//                endPoint: .bottom
//            )
//            .ignoresSafeArea()
//        )
        
    }

    

    
}

#Preview {
    WeatherView()
        .environmentObject(ViewModel())
}
