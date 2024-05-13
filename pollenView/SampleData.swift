//
//  SampleData.swift
//  pollenView
//
//  Created by Sam Roman on 5/13/24.
//

import SwiftUI

struct SampleData {
    static func generate() -> [DailyPollenForecast] {
        return [
            DailyPollenForecast(date: "Mon", details: [
                PollenDetail(type: .grass, level: 3.0),
                PollenDetail(type: .mold, level: 5.5),
                PollenDetail(type: .tree, level: 2.3),
                PollenDetail(type: .ragweed, level: 6.7)
            ]),
            DailyPollenForecast(date: "Tue", details: [
                PollenDetail(type: .grass, level: 6.0),
                PollenDetail(type: .mold, level: 4.5),
                PollenDetail(type: .tree, level: 7.1),
                PollenDetail(type: .ragweed, level: 3.3)
            ]),
            DailyPollenForecast(date: "Wed", details: [
                PollenDetail(type: .grass, level: 2.5),
                PollenDetail(type: .mold, level: 6.0),
                PollenDetail(type: .tree, level: 5.5),
                PollenDetail(type: .ragweed, level: 4.2)
            ]),
            DailyPollenForecast(date: "Thu", details: [
                PollenDetail(type: .grass, level: 7.0),
                PollenDetail(type: .mold, level: 3.8),
                PollenDetail(type: .tree, level: 6.3),
                PollenDetail(type: .ragweed, level: 5.1)
            ]),
            DailyPollenForecast(date: "Fri", details: [
                PollenDetail(type: .grass, level: 5.5),
                PollenDetail(type: .mold, level: 6.5),
                PollenDetail(type: .tree, level: 4.0),
                PollenDetail(type: .ragweed, level: 7.2)
            ]),
            DailyPollenForecast(date: "Sat", details: [
                PollenDetail(type: .grass, level: 4.0),
                PollenDetail(type: .mold, level: 5.0),
                PollenDetail(type: .tree, level: 7.5),
                PollenDetail(type: .ragweed, level: 3.9)
            ]),
            DailyPollenForecast(date: "Sun", details: [
                PollenDetail(type: .grass, level: 6.8),
                PollenDetail(type: .mold, level: 4.2),
                PollenDetail(type: .tree, level: 3.4),
                PollenDetail(type: .ragweed, level: 5.7)
            ])
        ]
    }
}
