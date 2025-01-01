//
//  HourlyForecastView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2024-12-29.
//

import SwiftUI

struct HourlyForecastView: View {
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Cloudy conditions will continue for the rest of the day. Wind guessed to be 10mph.")
                .font(.system(size: 14))
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .shadow(radius: 2.0)
                .padding(.bottom, 5)
            
            Divider()
                .padding(.bottom, 10)
            
            ScrollView(.horizontal) {
                HStack { 
                    ForEach(0..<23) {_ in
                        VStack {
                            Text("Now")
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            
                            Image(systemName: "sun.max.fill")
                                .foregroundColor(.yellow)
                                .padding(.vertical, 2)
                            
                            Text("68")
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                        }
                        .padding(.trailing, 14)
                        
                    }
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16.0))
        
    }
}

#Preview {
    ScrollView {
        HourlyForecastView()
            .padding()
    }
    .background(Color.blue)
}
