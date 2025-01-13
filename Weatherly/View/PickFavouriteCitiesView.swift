//
//  PickFavouriteCitiesView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-02.
//

import SwiftData
import SwiftUI

struct PickFavouriteCitiesView: View {

    @EnvironmentObject var viewModel: ViewModel

    @Query(sort: \City.name, order: .forward) private var favoriteCities: [City]
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            if favoriteCities.isEmpty {
                Text("No favourite cities added.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(favoriteCities, id: \.self) { city in
                        HStack {
                            Text(city.name.capitalized)

                            Spacer()

                            // Toggle the showOnPlaceMap value for the selected city
                            Button {

                                if let index =
                                    favoriteCities
                                    .firstIndex(where: { $0.id == city.id })
                                {
                                    favoriteCities[index]
                                        .showOnPlaceMap.toggle()

                                }
                            } label: {
                                Image(
                                    systemName: city.showOnPlaceMap
                                        ? "checkmark.circle.fill"
                                        : "plus.circle"
                                )
                                .foregroundColor(
                                    city.showOnPlaceMap ? .green : .red)
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
