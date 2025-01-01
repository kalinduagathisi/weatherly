//
//  WeatherSummeryView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2024-12-29.
//

import SwiftUI

struct WeatherSummeryView: View {
    
    let cityName: String
    let currentWeather: CurrentWeather
    let dailyTemperature: DailyTemperature
    
    var body: some View {

        VStack {
            
            Text("My Location")
                .font(.system(size: 12))
                .foregroundColor(.white)

            Text(cityName)
                .font(.system(size: 32))
                .foregroundColor(.white)

            Text("\(currentWeather.temp)")
                .font(.system(size: 100))
                .fontWeight(.thin)
                .foregroundColor(.white)

            Text("\(currentWeather.weather[0])")
                .font(.system(size: 16))
                .foregroundColor(.white)

            Text("\((dailyTemperature.min))° \(Int(dailyTemperature.max))°")
                .font(.system(size: 24))
                .foregroundColor(.white)
        }

    }
}

#Preview {
    ScrollView {
        HStack {
            Spacer()
            WeatherSummeryView(
                cityName: "Colombo",
                currentWeather: MockData.currentWeather,
                dailyTemperature: MockData.dailyTemperature
            )
            .padding(.top, 60)
            Spacer()
        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.blue)
//    .ignoresSafeArea()
}

