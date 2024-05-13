//
//  pollenWidgetBundle.swift
//  pollenWidget
//
//  Created by Sam Roman on 5/12/24.
//

import WidgetKit
import SwiftUI

@main
struct PollenWidgetsBundle: WidgetBundle {
    var body: some Widget {
        PollenForecastWidget()
        PollenDayWidget()
    }
}

