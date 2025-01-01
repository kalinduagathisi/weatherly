//
//  DailyForecastProgressView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-01.
//

import SwiftUI

struct DailyForecastProgressView: View {
    var body: some View {
        
        ProgressView(value: 0.5, total: 1.0)
    }
}

#Preview {
    DailyForecastProgressView()
}
