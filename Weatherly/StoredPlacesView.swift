//
//  StoredPlacesView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-02.
//

import SwiftUI

struct StoredPlacesView: View {

    @EnvironmentObject var viewModel: WeatherViewModel

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.favoriteCities) { city in
                        Text(city.name)
                            .swipeActions {
                                Button(role: .destructive) {
                                    viewModel.removeCity(city)
                                } label: {
                                    Label("Remove", systemImage: "trash")
                                }
                            }
                    }
                }
                .listStyle(.plain)
            }
            .padding(.vertical)
            .navigationTitle("Saved Locations")
        }
    }
}

#Preview {
    StoredPlacesView()
        .environmentObject(WeatherViewModel())
}
