//
//  WeatherSummeryView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2024-12-29.
//

import SwiftUI

struct WeatherSummeryView: View {
    var body: some View {

        VStack {
            Text("My Location")
                .font(.system(size: 12))
                .foregroundColor(.white)

            Text("Colombo")
                .font(.system(size: 32))
                .foregroundColor(.white)

            Text("84°")
                .font(.system(size: 100))
                .fontWeight(.thin)
                .foregroundColor(.white)

            Text("Mostly Cloudy")
                .font(.system(size: 16))
                .foregroundColor(.white)

            Text("H:88° L:70°")
                .font(.system(size: 24))
                .foregroundColor(.white)
        }

    }
}

#Preview {

    ScrollView {
        HStack {
            Spacer()
            
            WeatherSummeryView()
                .padding(.top, 60)
            
            Spacer()
        }
    }
//    .frame(maxWidth: .infinity, maxHeight: .infinity)  // Parent can still add this
    .background(Color.blue)  // Background set in parent
    //    .ignoresSafeArea()

}
