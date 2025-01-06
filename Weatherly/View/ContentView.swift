//
//  ContentView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2024-12-28.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = ViewModel()

    var body: some View {

        if viewModel.isLoading {
            // Show loading view
            VStack {
                ProgressView("Fetching weather data...")
                    .progressViewStyle(
                        CircularProgressViewStyle(tint: .blue)
                    )
                    .font(.headline)
                Spacer()
            }
            
        } else {
            TabView {
                WeatherView()
                    .tabItem {
                        Label("Weather", systemImage: "cloud.fill")
                    }
                    .environmentObject(viewModel)

                PlaceMapView()
                    .tabItem {
                        Label("Place Map", systemImage: "map.fill")
                    }
                    .environmentObject(viewModel)

                StoredPlacesView()
                    .tabItem {
                        Label(
                            "Stored Places",
                            systemImage: "list.bullet.rectangle.fill")
                    }
                    .environmentObject(viewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
