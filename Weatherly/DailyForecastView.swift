//
//  DailyForecastView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2024-12-29.
//

import SwiftUI

struct DailyForecastView: View {
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(Color.white.opacity(0.6))
                
                Text("5 day forecast".uppercased())
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .foregroundColor(Color.white.opacity(0.6))
            }
            
            Divider()
            
            ForEach(0..<5) { _ in
                HStack {
                    Text("Today")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    Image(systemName: "sun.max.fill")
                        .foregroundColor(.yellow)
                    
                    Spacer()
                        .frame(maxWidth: 50)
                    
                    Text("52°")
                        .foregroundColor(Color.white.opacity(0.6))
                    
                    DailyForecastProgressView()
                        .frame(maxWidth: 100)
                    
                    
                    Text("82°")
                        .foregroundColor(Color.white)
                }
                Divider()
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16.0))
    }
}

#Preview {
    ScrollView {
        HStack {
            Spacer()
            DailyForecastView()
                .padding()
            Spacer()
        }
    }
    .background(Color.blue)
}
