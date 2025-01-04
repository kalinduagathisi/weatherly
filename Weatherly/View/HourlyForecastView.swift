//
//  HourlyForecastView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2024-12-29.
//

import SwiftUI

struct HourlyForecastView: View {

    let hourlyWeather: [HourlyWeather]

    var body: some View {
        VStack(alignment: .leading) {
            // Header description
            Text(
                "Cloudy conditions will continue for the rest of the day. Wind guessed to be 10mph."
            )
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
                            Text(formattedHour(from: hour.dt))
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)

                            // Weather icon
                            Image(
                                systemName: weatherIcon(
                                    for: hour.weather.first?.main ?? "")
                            )
                            .foregroundColor(.white)
                            .padding(.vertical, 2)

                            // Temperature
                            Text(
                                "\(Int(kelvinToFahrenheit(kelvin: hour.temp)))°"
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

    // Helper to determine the appropriate weather icon
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
        default:
            return "cloud.fill"
        }
    }
    
    // convert K to f
    func kelvinToFahrenheit(kelvin: Double) -> Double {
        return (kelvin - 273.15) * 9/5 + 32
    }
    
    // Helper to format the hour
    func formattedHour(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "h a" // e.g., "1 PM"
        return formatter.string(from: date)
    }}

#Preview {
    HourlyForecastView(
        hourlyWeather: MockData.hourlyWeather
    )
    .padding()
    .background(Color.blue)
}
