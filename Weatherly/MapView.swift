//
//  MapView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-02.
//

import SwiftUI
import MapKit

struct MapView: View {
    
//    @StateObject var viewModel = LocationViewModel()
    @Binding var selectedMark: City?
    
    var body: some View {
        VStack {
            
            Map()
            
        }
    }
}

#Preview {
    MapView(selectedMark: .constant(MockCityData.dummyCity))
}
