//
//  LocationViewModel.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-02.
//

import Foundation
import CoreLocation

class LocationViewModel: ObservableObject {
    
    @Published var selectedCities: [City] = []
    @Published var coordinate: CLLocationCoordinate2D? = nil
    @Published var geocodingError: Error? = nil
    
    private let geocoder = CLGeocoder()
    
    func getCoordinateFrom(address: String) {
        geocoder.geocodeAddressString(address) { [weak self] placemarks, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.geocodingError = error
                    self?.coordinate = nil
                } else if let coordinate = placemarks?.first?.location?.coordinate {
                    self?.coordinate = coordinate
                    self?.geocodingError = nil
                }
            }
        }
    }
}
