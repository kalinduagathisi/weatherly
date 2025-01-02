//
//  PlacesView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2024-12-28.
//

import SwiftUI

struct PlaceMapView: View {

    @State var address: String = "London"
    @State var selectedMark: City?

    var body: some View {

        NavigationStack {

            // search bar
            HStack {
                TextField("Enter address", text: $address)
                    .padding(.leading, 10)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .submitLabel(.search)  // This will make the return key appear as "Search"
                    .onSubmit {
                        //                        Task {
                        //                            await searchWeather()
                        //                        }
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

            // map view
            MapView(selectedMark: $selectedMark)

            //            Divider()

            // list 5 favourite places
            ScrollView(.vertical, showsIndicators: false) {

                Text("Top favourite places")
                    .font(.headline)
                Text("London")
                Text("Amsterdam")
                Text("Scotland")
                Text("Colorado")
                Text("Tokyo")

            }
            .padding()

        }

    }
}

#Preview {
    PlaceMapView()
}
