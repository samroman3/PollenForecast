//
//  PollenForecastView.swift
//  pollenView
//
//  Created by Sam Roman on 5/12/24.
//

import SwiftUI

struct PollenForecastView: View {
    let forecasts: [PollenForecast] = [
        PollenForecast(date: "Mon", level: 3),
        PollenForecast(date: "Tue", level: 7),
        PollenForecast(date: "Wed", level: 5),
        PollenForecast(date: "Thu", level: 8),
        PollenForecast(date: "Fri", level: 6),
        PollenForecast(date: "Sat", level: 4),
        PollenForecast(date: "Sun", level: 9)
    ]
    
    var body: some View {
        VStack {
            Text("Pollen Forecast")
                .font(.headline)
                .padding(.bottom, 8)
            
            ForEach(forecasts, id: \.date) { forecast in
                VStack(spacing: 4) {
                    PollenIndicator(level: forecast.level)
                    Text(forecast.date)
                        .font(.caption)
                }
                .padding(.bottom, 8)
            }
        }
        .padding()
    }
}

struct PollenForecast {
    let date: String
    let level: Int // 0 - 9
}

struct PollenIndicator: View {
    let level: Int
    let maxDots = 9
    
    var body: some View {
        VStack(spacing: 2) {
            ForEach(0..<maxDots / 2) { row in
                HStack(spacing: 2) {
                    Circle()
                        .fill(row * 2 + 1 <= level ? colorForLevel(row * 2 + 1) : Color.white)
                        .frame(width: 8, height: 8)
                    Circle()
                        .fill(row * 2 + 2 <= level ? colorForLevel(row * 2 + 2) : Color.white)
                        .frame(width: 8, height: 8)
                }
            }
        }
    }
    
    func colorForLevel(_ level: Int) -> Color {
        let colors = Gradient(colors: [.green, .yellow, .orange, .red])
        return LinearGradient(gradient: colors, startPoint: .bottom, endPoint: .top)
            .mask(Rectangle().frame(height: CGFloat(level) * 10))
            .foregroundColor(.clear)
    }
}

struct ContentView: View {
    var body: some View {
        PollenForecastView()
    }
}

@main
struct PollenApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


import SwiftUI

@main
struct PollenWatchApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                PollenForecastView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}

struct NotificationController: WKUserNotificationHostingController<NotificationView> {
    override var body: NotificationView {
        return NotificationView()
    }
}

struct NotificationView: View {
    var body: some View {
        Text("Pollen Forecast Notification")
    }
}
