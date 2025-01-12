//
//  PlacesView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2024-12-28.
//

import SwiftUI

struct PlaceMapView: View {

    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.modelContext) private var modelContext
    @State var selectedMark: City?

    var body: some View {

        NavigationStack {

            // search bar
            HStack {
                TextField("Enter address", text: $viewModel.searchedCity)
                    .padding(.leading, 10)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .submitLabel(.search)
                    .onSubmit {
                        Task {
                            await viewModel.searchWeather(
                                cityName: viewModel.searchedCity,
                                modelContext: modelContext)
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
                    .shadow(
                        color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
            )
            .padding(.horizontal, 20)

            .toolbar {
                NavigationLink(destination: PickFavouriteCitiesView()) {
                    Image(systemName: "heart")
                }
            }
            .padding(.vertical)

            // map view
            MapView(selectedMark: $selectedMark)

        }

    }
}

#Preview {
    PlaceMapView()
        .environmentObject(ViewModel())
}
