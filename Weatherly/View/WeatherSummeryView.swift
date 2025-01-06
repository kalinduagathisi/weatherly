//
//  WeatherSummeryView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2024-12-29.
//

import SwiftUI

struct WeatherSummeryView: View {

    @StateObject var viewModel = ViewModel()

    let cityName: String
    let currentWeather: CurrentWeather
    let dailyWeather: DailyWeather

    var body: some View {

        VStack {

            Text("My Location")
                .font(.system(size: 12))
                .foregroundColor(.white)

            Text(cityName.capitalized)
                .font(.system(size: 32))
                .foregroundColor(.white)

            Text(
                "\( currentWeather.temp, specifier: "%.1f")°"
            )
            .font(.system(size: 100))
            .fontWeight(.thin)
            .foregroundColor(.white)

            Text(currentWeather.weather.first?.description.capitalized ?? "N/A")
                .font(.system(size: 16))
                .foregroundColor(.white)

            Text("H :\(dailyWeather.temp.max, specifier: "%.1f")°  L :\( dailyWeather.temp.min, specifier: "%.1f")°")
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
                dailyWeather: MockData.dailyWeather
            )
            .padding(.top, 60)
            Spacer()
        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.blue)
    //    .ignoresSafeArea()
}
