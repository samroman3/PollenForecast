//
//  PollenDayWidget.swift
//  pollenView
//
//  Created by Sam Roman on 5/13/24.
//

import WidgetKit
import SwiftUI

struct PollenDayWidgetEntryView: View {
    var entry: SimpleEntry

    var body: some View {
        PollenDayView(forecasts: entry.forecasts)
            .containerBackground(.black, for: .widget)
            .padding()
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let forecasts: [DailyPollenForecast]
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), forecasts: SampleData.generate())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        completion(SimpleEntry(date: Date(), forecasts: SampleData.generate()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let entries = [SimpleEntry(date: Date(), forecasts: SampleData.generate())]
        completion(Timeline(entries: entries, policy: .atEnd))
    }
}

struct PollenDayWidget: Widget {
    let kind: String = "PollenDayWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            PollenDayWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Pollen Day Widget")
        .description("Displays detailed pollen levels for Monday.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}


