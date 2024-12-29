//
//  ContentView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2024-12-28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            WeatherView()
                .tabItem {
                    Label("Weather", systemImage: "cloud.fill")
                }
            
            WeatherView()
                .tabItem {
                    Label("Places", systemImage: "map.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
