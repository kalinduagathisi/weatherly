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
            
            PlaceMapView()
                .tabItem {
                    Label("Place Map", systemImage: "map.fill")
                }
            
            StoredPlacesView()
                .tabItem {
                    Label("Stored Places", systemImage: "list.bullet.rectangle.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
