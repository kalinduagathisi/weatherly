//
//  ExtraWeatherInfoView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-02.
//

import SwiftUI

struct ExtraWeatherInfoView: View {
    
    let currentWeather: CurrentWeather
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "hourglass.bottomhalf.filled")
                    .foregroundColor(Color.white.opacity(0.6))
                
                Text("More Information")
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .foregroundColor(Color.white.opacity(0.6))
            }
            
            Divider()
            
            HStack {
                Image(systemName: "wind")
                    .foregroundColor(Color.white)

                Text("Wind Speed")
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                Spacer()
                Text("\(currentWeather.wind_speed, specifier: "%.1f")")
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
            }
            .padding(.vertical, 1)
            
            HStack {
                Image(systemName: "angle")
                    .foregroundColor(Color.white)

                Text("Wind Degree")
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                Spacer()
                Text("\(currentWeather.wind_deg, specifier: "%.2f")°")
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
            }
            .padding(.vertical, 1)
            
            HStack {
                Image(systemName: "humidity")
                    .foregroundColor(Color.white)

                Text("Humidity")
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                Spacer()
                Text("\(currentWeather.humidity)")
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
            }
            .padding(.vertical, 1)
            
            HStack {
                Image(systemName: "snowflake")
                    .foregroundColor(Color.white)

                Text("Dev Point")
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                Spacer()
                Text("\(currentWeather.dew_point, specifier: "%.1f")")
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
            }
            .padding(.vertical, 1)
            
            HStack {
                Image(systemName: "tirepressure")
                    .foregroundColor(Color.white)

                Text("Pressure")
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                Spacer()
                Text("\(currentWeather.pressure)")
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
            }
            .padding(.vertical, 1)
            
            HStack {
                Image(systemName: "sun.max.trianglebadge.exclamationmark")
                    .foregroundColor(Color.white)

                Text("UVI")
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                Spacer()
                Text("\(currentWeather.uvi, specifier: "%.1f")")
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
            }
            .padding(.vertical, 1)
            
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
            ExtraWeatherInfoView(currentWeather: MockData.currentWeather)
            Spacer()
        }
    }
    .background(.blue)
    
}
