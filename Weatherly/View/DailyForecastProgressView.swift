//
//  DailyForecastProgressView.swift
//  Weatherly
//
//  Created by Kalindu Agathisi on 2025-01-01.
//

import SwiftUI

struct DailyForecastProgressView: View {
    let progress: Double

    var body: some View {
        ProgressView(value: progress)
            .progressViewStyle(LinearProgressViewStyle(tint: .yellow))
    }
}

#Preview {
    DailyForecastProgressView(progress: 0.5)
}
