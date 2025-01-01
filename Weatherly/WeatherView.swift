//
//  WeatherView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2024-12-28.
//

import SwiftUI

struct WeatherView: View {

    @StateObject  var viewModel = WeatherViewModel()
    @State var address: String = "colombo"
    
    
    var body: some View {

        ScrollView {

            VStack {
                
                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                }
                else {
                    
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
                DailyForecastView()
            }
            .padding(.horizontal)
        }
        .onAppear {
            Task {
                do {
                    let coordinate = try await viewModel.getCoordinateFrom(address: address)
                    await viewModel.fetchWeather(lat: coordinate.latitude, lon: coordinate.longitude)
                } catch {
                    print("Geocoding failed: \(error.localizedDescription)")
                }
            }
        }

        
        .background(.blue)
    }
}

#Preview {
    WeatherView()
}
