//
//  DailyForecastView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2024-12-29.
//

import SwiftUI

struct DailyForecastView: View {

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
                    Text(formatDate(weather.dt))
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)

                    Spacer()

                    Image(
                        systemName: weatherIcon(
                            for: weather.weather.first?.main ?? "")
                    )
                    .foregroundColor(.white)

                    Spacer()
                        .frame(maxWidth: 50)

                    Text("\(Int(weather.temp.min))°")
                        .foregroundColor(Color.white.opacity(0.6))

                    DailyForecastProgressView(
                        progress: progressValue(
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

    // Helper function to format date from UNIX timestamp
    private func formatDate(_ dt: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE" // Example: Mon, Tue
        return formatter.string(from: date)
    }
    
    // Helper function to map weather condition to SF Symbols
    private func weatherIcon(for condition: String) -> String {
        switch condition.lowercased() {
        case "clear":
            return "sun.max.fill"
        case "clouds":
            return "cloud.fill"
        case "rain":
            return "cloud.rain.fill"
        case "snow":
            return "cloud.snow.fill"
        case "thunderstorm":
            return "cloud.bolt.fill"
        case "drizzle":
            return "cloud.drizzle.fill"
        default:
            return "cloud.fill"
        }
    }
    
    // Helper function to calculate progress for the temperature bar
    private func progressValue(minTemp: Double, maxTemp: Double) -> Double {
        let range = maxTemp - minTemp
        return range > 0 ? (maxTemp - minTemp) / range : 0.5
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
