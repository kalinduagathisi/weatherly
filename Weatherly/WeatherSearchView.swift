//
//  WeatherSearchView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-02.
//

import SwiftUI

struct WeatherSearchView: View {

    @Binding var address: String
    @StateObject var viewModel = WeatherViewModel()

    var body: some View {
        // Search bar that triggers API call on return key press
        HStack {
            TextField("Enter address", text: $address)
                .padding(.leading, 10)
                .font(.system(size: 16))
                .foregroundColor(.black)
                .submitLabel(.search)  // This will make the return key appear as "Search"
                .onSubmit {
                    // Trigger the API call when the return key is pressed
                    Task {
                        await searchWeather()
                    }
                }

            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.trailing, 10)
        }
        .padding()
        .frame(height: 45)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white.opacity(0.8))
                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
        )
        .padding(.horizontal, 20)

    }
    
    // Helper method to handle async weather search
        private func searchWeather() async {
            do {
                // Call the geocoding API
                let coordinate = try await viewModel.getCoordinateFrom(address: address)
                
                // Fetch weather data using the obtained coordinates
                await viewModel.fetchWeather(lat: coordinate.latitude, lon: coordinate.longitude)
            } catch {
                print("Geocoding failed: \(error.localizedDescription)")
            }
        }

}

#Preview {
    WeatherSearchView(address: .constant("London"))
}
