//
//  PollenForecastWidget.swift
//  pollenWidget
//
//  Created by Sam Roman on 5/12/24.
//

import WidgetKit
import SwiftUI

struct PollenForecastWidgetEntryView: View {
    var entry: SimpleEntry

    var body: some View {
        GeometryReader { geometry in
            VStack{
            HStack(alignment: .center, spacing: 6) {
                Image(systemName: "circle.hexagongrid")
                    .foregroundStyle(.white)
                    .frame(width: 24, height: 24)
                Text("Pollen Forecast")
                    .font(.body)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                Spacer()
            }
            PollenForecastView(maxRows: maxRowsForSize(geometry.size))
        }
        }.containerBackground(.black, for: .widget)
    }
    
    func maxRowsForSize(_ size: CGSize) -> Int {
        if size.width > 300 { // Wide widget
            return 7
        } else {
            switch size.height {
            case 0..<150:
                return 3
            case 150..<300:
                return 4
            default:
                return 7
            }
        }
    }
}

struct PollenForecastWidget: Widget {
    let kind: String = "PollenForecastWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            PollenForecastWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Pollen Forecast Widget")
        .description("Displays the pollen forecast for the next 7 days.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
