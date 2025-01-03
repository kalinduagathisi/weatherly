//
//  WeatherlyApp.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2024-12-28.
//

import SwiftUI

@main
struct WeatherlyApp: App {
    
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
