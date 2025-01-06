//
//  MapView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-02.
//

import MapKit
import SwiftUI

struct MapView: View {

    @EnvironmentObject var viewModel: ViewModel
    @Binding var selectedMark: City?

    var body: some View {
        VStack {

            Map(selection: $selectedMark) {
                ForEach(Array(viewModel.selectedCities), id: \.id) { city in
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
