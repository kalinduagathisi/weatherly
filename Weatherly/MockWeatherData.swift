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
        temp: 29.5,
        feelsLike: 30.2,
        pressure: 1014,
        humidity: 89,
        weather: [
            WeatherDetail(main: "Clouds", description: "Partly Cloudy", icon: "04d")
        ]
    )
    
    static let dailyTemperature = DailyTemperature(
        day: 29.5,
        min: 25.0,
        max: 32.0
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
                weather: [
                    WeatherDetail(main: "Rain", description: "Light Rain", icon: "10d")
                ]
            )
        ],
        dailyTemp: DailyTemperature(
            day: 29.5,
            min: 25.0,
            max: 32.0
        )
//        alerts: nil
    )
}

