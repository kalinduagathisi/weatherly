//
//  PickFavouriteCitiesView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-02.
//

import SwiftUI

struct PickFavouriteCitiesView: View {

    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            if viewModel.favoriteCities.isEmpty {
                Text("No favourite cities added.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(viewModel.favoriteCities, id: \.self) { city in
                        HStack {
                            Text(city.name)

                            Spacer()

                            if viewModel.selectedCities.contains(city) {
                                Button {
                                    viewModel.selectedCities.remove(city)
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.red)
                                }
                            } else {
                                Button {
                                    viewModel.selectedCities.insert(city)
                                } label: {
                                    Image(systemName: "plus.circle")
                                        .foregroundColor(.green)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Select for markdown on map")
            }
        }
    }
}

#Preview {
    PickFavouriteCitiesView()
        .environmentObject(ViewModel())
}
