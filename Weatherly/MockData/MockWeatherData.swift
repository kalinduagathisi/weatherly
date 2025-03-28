//
//  MockWeatherData.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-01.
//

import Foundation

struct MockData {
    static let currentWeather = CurrentWeather(
        dt: 1684929490,
        temp: 29.8,
        feelsLike: 30.2,
        pressure: 1014,
        humidity: 89,
        wind_speed: 4.3,
        wind_deg: 43.0,
        dew_point: 3.4,
        uvi: 0.0,
        weather: [
            WeatherDetail(main: "Clouds", description: "Partly Cloudy", icon: "04d")
        ]
    )
    
    static let hourlyWeather: [HourlyWeather] = [
            HourlyWeather(dt: 1672616400, temp: 29.8, weather: [WeatherDetail(main: "Clouds", description: "cloudy", icon: "cloud.fill")]),
            HourlyWeather(dt: 1672620000, temp: 29.8, weather: [WeatherDetail(main: "Clear", description: "clear sky", icon: "sun.max.fill")]),
            // Add more mock entries here
        ]
    
    static let dailyWeather = DailyWeather(
        dt: 1684951200,
        temp: dailyTemperature,
        summary: "Expect a day of partly cloudy with rain",
        weather: [
            WeatherDetail(main: "Rain", description: "Light Rain", icon: "10d")
        ]
    )
    
    static let mockDailyWeatherData = [
        DailyWeather(
                    dt: Int(Date().timeIntervalSince1970),
                    temp: DailyTemperature(day: 75, min: 50, max: 80),
                    summary: "Expect a day of partly cloudy with rain",
                    weather: [WeatherDetail(main: "Clear", description: "Clear sky", icon: "01d")]
                ),
                DailyWeather(
                    dt: Int(Date().addingTimeInterval(86400).timeIntervalSince1970),
                    temp: DailyTemperature(day: 70, min: 52, max: 75),
                    summary: "Expect a day of partly cloudy with rain",
                    weather: [WeatherDetail(main: "Clouds", description: "Partly cloudy", icon: "03d")]
                ),
                DailyWeather(
                    dt: Int(Date().addingTimeInterval(86400 * 2).timeIntervalSince1970),
                    temp: DailyTemperature(day: 68, min: 55, max: 78),
                    summary: "Expect a day of partly cloudy with rain",
                    weather: [WeatherDetail(main: "Rain", description: "Light rain", icon: "10d")]
                ),
                DailyWeather(
                    dt: Int(Date().addingTimeInterval(86400 * 3).timeIntervalSince1970),
                    temp: DailyTemperature(day: 65, min: 53, max: 82),
                    summary: "Expect a day of partly cloudy with rain",
                    weather: [WeatherDetail(main: "Snow", description: "Snow showers", icon: "13d")]
                ),
                DailyWeather(
                    dt: Int(Date().addingTimeInterval(86400 * 4).timeIntervalSince1970),
                    temp: DailyTemperature(day: 60, min: 49, max: 74),
                    summary: "Expect a day of partly cloudy with rain",
                    weather: [WeatherDetail(main: "Thunderstorm", description: "Thunderstorm", icon: "11d")]
                )
    ]
    
    static let dailyTemperature = DailyTemperature(
        day: 298.14,
        min: 29.8,
        max: 24.8
    )
    
    static let weatherResponse = WeatherResponse(
        lat: 33.44,
        lon: -94.04,
        timezone: "America/Chicago",
        timezoneOffset: -18000,
        current: currentWeather,
        hourly: [],
        daily: [
            DailyWeather(
                dt: 1684951200,
                temp: dailyTemperature,
                summary: "Expect a day of partly cloudy with rain",
                weather: [
                    WeatherDetail(main: "Rain", description: "Light Rain", icon: "10d")
                ]
            )
        ]
//        dailyTemp: DailyTemperature(
//            day: 29.5,
//            min: 25.0,
//            max: 32.0
//        )
//        alerts: nil
    )
    
    static let mockAirQualityEntry = AirQualityEntry(
        main: AQIMain(aqi: 2),
        components: AirComponents(
            co: 287.06,
            no: 0.0,
            no2: 10.2,
            o3: 50.78,
            so2: 1.77,
            pm2_5: 3.8,
            pm10: 6.67,
            nh3: 2.82
        ),
        dt: 1735787270
    )
}

