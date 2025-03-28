//
//  HourlyForecastView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2024-12-29.
//

import SwiftUI

struct HourlyForecastView: View {

    @StateObject var viewModel = ViewModel()

    let hourlyWeather: [HourlyWeather]
    let dailyWeather: [DailyWeather]

    var body: some View {
        VStack(alignment: .leading) {
            // Header description
            Text(dailyWeather.first?.summary ?? "N/A")
                .font(.system(size: 14))
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .shadow(radius: 2.0)
                .padding(.bottom, 5)

            Divider()
                .padding(.bottom, 10)

            // Scrollable hourly forecast
            ScrollView(.horizontal) {
                HStack {
                    ForEach(hourlyWeather, id: \.dt) { hour in
                        VStack {
                            // Hour
                            Text(viewModel.formattedHour(from: hour.dt))
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)

                            // Weather icon
                            Image(
                                systemName: viewModel.weatherIcon(
                                    for: hour.weather.first?.main ?? "")
                            )
                            .foregroundColor(.white)
                            .padding(.vertical, 2)

                            // Temperature
                            Text(
                                "\(hour.temp, specifier: "%.1f")°"
                            )
                            .font(.system(size: 20))
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                        }
                        .padding(.trailing, 14)
                    }
                }
            }
        }
        .padding()
        .background(
            .ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16.0))
    }

}

#Preview {
    HourlyForecastView(
        hourlyWeather: MockData.hourlyWeather,
        dailyWeather: MockData.mockDailyWeatherData
    )
    .padding()
    .background(Color.blue)
}
