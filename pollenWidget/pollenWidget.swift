//
//  pollenWidget.swift
//  pollenWidget
//
//  Created by Sam Roman on 5/12/24.
//

import WidgetKit
import SwiftUI

struct PollenWidgetEntryView: View {
    var entry: SimpleEntry

    var body: some View {
        GeometryReader { geometry in
                PollenForecastView(maxRows: maxRowsForSize(geometry.size))
                    .containerBackground(.black, for: .widget)
        }
    }
    
    // Determines the maximum number of rows based on widget size
    func maxRowsForSize(_ size: CGSize) -> Int {
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

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        completion(SimpleEntry(date: Date()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let entries = [SimpleEntry(date: Date())]
        completion(Timeline(entries: entries, policy: .atEnd))
    }
}

struct PollenWidget: Widget {
    let kind: String = "PollenWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            PollenWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Pollen Forecast Widget")
        .description("Displays the pollen forecast for the next 7 days.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
