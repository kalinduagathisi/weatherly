//
//  CurrentAirQualityView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-02.
//

import SwiftUI

struct CurrentAirQualityView: View {

    let airQualityEntry: AirQualityEntry

    var body: some View {
        VStack(alignment: .leading) {

            // display title
            HStack {
                Image(systemName: "wind")
                    .foregroundColor(.white.opacity(0.6))

                Text("Air Quality".uppercased())
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .foregroundColor(.white.opacity(0.6))
            }

            // display different gas indexes
            ScrollView(.horizontal, showsIndicators: false) {

                HStack {
                    ForEach(AirComponents.allComponents, id: \.key) {
                        component in
                        VStack {
                            Image(component.iconName)  // Use dynamic icon names
                                .resizable()
                                .cornerRadius(10)
                            
                            Text(
                                "\(component.value(airQualityEntry.components), specifier: "%.2f")"
                            )
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        }
                        Spacer()
                    }
                }
                .padding()

            }
        }
        .padding()
        .background(
            .ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16.0))
    }
}

// Extension to manage AirComponents dynamically
extension AirComponents {
    static let allComponents:
        [(key: String, iconName: String, value: (AirComponents) -> Double)] = [
            ("SO₂", "so2", { $0.so2 }),
            ("NO", "no", { $0.no }),
            ("O₃", "voc", { $0.o3 }),
            ("PM₁₀", "pm", { $0.pm10 }),
        ]
}

#Preview {
    ScrollView {
        HStack {
            Spacer()
            CurrentAirQualityView(airQualityEntry: MockData.mockAirQualityEntry)
            Spacer()
        }
    }
    .background(.blue)

}
