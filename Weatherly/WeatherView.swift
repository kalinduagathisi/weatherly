//
//  WeatherView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2024-12-28.
//

import SwiftUI

struct WeatherView: View {

    @StateObject  var viewModel = WeatherViewModel()
    @State var location: String = ""

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
                       let dailyTemperature = viewModel.dailyTemperature
                    {
                        // weather summery view
                        WeatherSummeryView(
                            cityName: location,
                            currentWeather: currentWeather,
                            dailyTemperature: dailyTemperature
                        )
                        .padding(.top, 60)
                        .padding(.bottom, 40)
                    }
                }
                

                // hourly forecast view
                HourlyForecastView()

                // 5-day forecast view
                DailyForecastView()
            }
            .padding(.horizontal)
        }
        .onAppear() {
            Task {
//                await viewModel.fetchWeather(for: location)
            }
        }
        
        .background(.blue)
    }
}

#Preview {
    WeatherView()
}
