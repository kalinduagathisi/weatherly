//
//  DailyForecastView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2024-12-29.
//

import SwiftUI

struct DailyForecastView: View {

    @StateObject var viewModel = ViewModel()

    let dailyWeather: [DailyWeather]

    var body: some View {

        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(Color.white.opacity(0.6))

                Text("5 day forecast".uppercased())
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .foregroundColor(Color.white.opacity(0.6))
            }

            Divider()

            // Use ForEach with real API data
            ForEach(dailyWeather.prefix(5), id: \.dt) { weather in
                HStack {
                    Text(viewModel.formatDate(weather.dt))
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)

                    Spacer()

                    Image(
                        systemName: viewModel.weatherIcon(
                            for: weather.weather.first?.main ?? "")
                    )
                    .foregroundColor(.white)

                    Spacer()
                        .frame(maxWidth: 50)

                    Text("\(Int(weather.temp.min))°")
                        .foregroundColor(Color.white.opacity(0.6))

                    DailyForecastProgressView(
                        progress: viewModel.progressValue(
                            minTemp: weather.temp.min,
                            maxTemp: weather.temp.max
                        )
                    )
                    .frame(maxWidth: 100)

                    Text("\(Int(weather.temp.max))°")
                        .foregroundColor(Color.white)
                }

                Divider()
            }
        }
        .padding()
        .background(
            .ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16.0))
    }

}

#Preview {
    ScrollView {
        HStack {
            Spacer()
            DailyForecastView(dailyWeather: MockData.mockDailyWeatherData)
                .padding()
            Spacer()
        }
    }
    .background(Color.blue)
}
