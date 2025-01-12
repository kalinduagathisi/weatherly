//
//  StoredPlacesView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-02.
//

import SwiftData
import SwiftUI

struct StoredPlacesView: View {

    @Query(sort: \City.name, order: .forward) private var favoriteCities: [City]
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            VStack {
                if favoriteCities.isEmpty {
                    Text("No saved locations yet.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(favoriteCities) { city in
                            Text(city.name.capitalized)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        viewModel.removeCity(
                                            city, modelContext: modelContext)
                                    } label: {
                                        Label("Remove", systemImage: "trash")
                                    }
                                }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .padding(.vertical)
            .navigationTitle("Saved Locations")
        }
    }
}

#Preview {
    StoredPlacesView()
        .environmentObject(ViewModel())
}
