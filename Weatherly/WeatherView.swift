//
//  WeatherView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2024-12-28.
//

import SwiftUI

struct WeatherView: View {

    var body: some View {

        ScrollView {
            
            VStack {
                
                // weather summery view
                WeatherSummeryView()
                    .padding(.top, 60)
                    .padding(.bottom, 40)
                
                // hourly forecast view
                HourlyForecastView()
            }
            .padding(.horizontal)
        }
        .background(.blue)
    }
}




#Preview {
    WeatherView()
}
