//
//  WeatherView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2024-12-28.
//

import SwiftUI

struct WeatherView: View {

    var body: some View {

        ScrollView {

            VStack {
                
                // weather summery view
                WeatherSummeryView()
                
                hourlyForecastView
            }
        }
        .background(.blue)
    }
}

// hourly forecast view
var hourlyForecastView: some View {
    VStack {
        Text("Cloudy conditions will continue for the rest of the day. Wind guessed to be 10mph")
        
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<23) {_ in
                    VStack {
                        Text("Now")
                        Text("☀️")
                        Text("68")
                    }
                    
                }
            }
        }
    }
    .padding()
    .background(Color.purple)
}

#Preview {
    WeatherView()
}
