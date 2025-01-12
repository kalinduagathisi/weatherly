//
//  MapView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-02.
//

import MapKit
import SwiftData
import SwiftUI

struct MapView: View {

    @EnvironmentObject var viewModel: ViewModel
    @Query(sort: \City.name, order: .forward) private var favoriteCities: [City]
    @Binding var selectedMark: City?

    var body: some View {
        VStack {

            Map(selection: $selectedMark) {
                // Filter cities where showOnPlaceMap is true
                ForEach(favoriteCities.filter { $0.showOnPlaceMap }, id: \.id) {
                    city in
                    Marker(
                        city.name,
                        coordinate: CLLocationCoordinate2D(
                            latitude: city.latitude,
                            longitude: city.longitude
                        ))
                }
            }
            .mapStyle(.hybrid)

        }
    }
}

#Preview {
    MapView(selectedMark: .constant(MockCityData.dummyCity))
        .environmentObject(ViewModel())
}
