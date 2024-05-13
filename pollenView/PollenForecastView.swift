//
//  PollenForecastView.swift
//  pollenView
//
//  Created by Sam Roman on 5/12/24.
//
//

import SwiftUI
import WidgetKit


// Main Pollen Forecast View
public struct PollenForecastView: View {
    private let forecasts: [PollenForecast] = [
        PollenForecast(date: "Mon", level: 3),
        PollenForecast(date: "Tue", level: 7),
        PollenForecast(date: "Wed", level: 5),
        PollenForecast(date: "Thu", level: 8),
        PollenForecast(date: "Fri", level: 6),
        PollenForecast(date: "Sat", level: 4),
        PollenForecast(date: "Sun", level: 9)
    ]
    
    private let maxRows: Int
    
    public init(maxRows: Int = 7) {
        self.maxRows = maxRows
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if maxRows == 7 {
                HStack(spacing: 15) {
                    ForEach(forecasts.prefix(maxRows), id: \.date) { forecast in
                        VStack(spacing: 10) {
                            PollenIndicator(level: forecast.level)
                            Text(forecast.date)
                                .font(.caption)
                        }
                    }
                }.padding()
            } else {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 8) { // Reduced spacing
                    ForEach(forecasts.prefix(maxRows), id: \.date) { forecast in
                        VStack(spacing: 2) {
                            PollenIndicator(level: forecast.level)
                            Text(forecast.date)
                                .font(.caption)
                        }
                    }
                }
            }
        }
        .cornerRadius(10)
        .shadow(radius: 4)
    }
}


public struct PollenForecast {
    public let date: String
    public let level: Int
    
    public init(date: String, level: Int) {
        self.date = date
        self.level = level
    }
}

// MARK: Pollen Indeicator
public struct PollenIndicator: View {
    let level: Int
    let maxDots = 9
    
    public init(level: Int) {
        self.level = level
    }
    
    public var body: some View {
        VStack(spacing: 2) {
            ForEach((0..<maxDots / 2).reversed(), id: \.self) { row in
                HStack(spacing: 2) {
                    Circle()
                        .fill(row * 2 + 1 <= level ? colorForLevel(row * 2 + 1) : Color.gray)
                        .frame(width: 12, height: 12)
                        .shadow(color: shadowColorForLevel(row * 2 + 1), radius: row * 2 + 1 <= level ? 4 : 0)
                    Circle()
                        .fill(row * 2 + 2 <= level ? colorForLevel(row * 2 + 2) : Color.gray)
                        .frame(width: 12, height: 12)
                        .shadow(color: shadowColorForLevel(row * 2 + 2), radius: row * 2 + 2 <= level ? 4 : 0)
                }
            }
        }
    }
    
    func colorForLevel(_ level: Int) -> Color {
        let gradientColors = [Color.green, Color.yellow, Color.orange, Color.red]
        let stops = gradientColors.count - 1
        let position = Double(level - 1) / Double(maxDots - 1)
        
        let index = Int(position * Double(stops))
        let lowerColor = gradientColors[index]
        let upperColor = gradientColors[min(index + 1, stops)]
        
        let ratio = position * Double(stops) - Double(index)
        let interpolatedColor = mixColors(lowerColor, upperColor, ratio: ratio)
        
        return interpolatedColor
    }
    
    func shadowColorForLevel(_ level: Int) -> Color {
        let baseColor = colorForLevel(level)
        return baseColor.opacity(0.6)
    }
    
    func mixColors(_ lower: Color, _ upper: Color, ratio: Double) -> Color {
        let lowerUIColor = UIColor(lower)
        let upperUIColor = UIColor(upper)
        
        let red = lowerUIColor.redValue * (1.0 - ratio) + upperUIColor.redValue * ratio
        let green = lowerUIColor.greenValue * (1.0 - ratio) + upperUIColor.greenValue * ratio
        let blue = lowerUIColor.blueValue * (1.0 - ratio) + upperUIColor.blueValue * ratio
        let alpha = lowerUIColor.alphaValue * (1.0 - ratio) + upperUIColor.alphaValue * ratio
        
        return Color(UIColor(red: red, green: green, blue: blue, alpha: alpha))
    }
}

extension UIColor {
    var redValue: CGFloat {
        return CIColor(color: self).red
    }
    
    var greenValue: CGFloat {
        return CIColor(color: self).green
    }
    
    var blueValue: CGFloat {
        return CIColor(color: self).blue
    }
    
    var alphaValue: CGFloat {
        return CIColor(color: self).alpha
    }
}


//MARK: Pollen Detail Row
struct PollenDetailRow: View {
    let level: Double
    let type: PollenType
    @Environment(\.widgetFamily) var widgetFamily
    
    enum PollenType: Encodable {
        
        case grass, mold, tree, ragweed
        
        var name: String {
            switch self {
            case .grass: return "Grass"
            case .mold: return "Mold"
            case .tree: return "Tree"
            case .ragweed: return "Ragweed"
            }
        }
        var iconName: String {
            switch self {
            case .grass: return "leaf"
            case .mold: return "microbe"
            case .tree: return "tree"
            case .ragweed: return "laurel.leading"
            }
        }
        
        var icon: Image {
            Image(systemName: iconName)
        }
    }
    
    var body: some View {
        if widgetFamily == .systemSmall {
            HStack(alignment:.center) {
                type.icon
                    .imageScale(.large)
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                Spacer()
                Text(String(format: "%.1f", level))
                    .font(.headline)
                    .foregroundStyle(colorForLevel(level))
            }
        } else {
            HStack {
                type.icon
                    .imageScale(.large)
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
                Text(type.name)
                    .font(.caption)
                    .foregroundStyle(.white)
                Text(String(format: "%.1f", level))
                    .font(.caption)
                    .foregroundStyle(colorForLevel(level))
            }
        }
    }
    
    func colorForLevel(_ level: Double) -> Color {
        switch level {
        case 0..<3:
            return .green
        case 3..<6:
            return .yellow
        case 6..<8:
            return .orange
        default:
            return .red
        }
    }
}


//MARK: Day View
struct PollenDayView: View {
    let forecasts: [DailyPollenForecast]
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(forecasts.prefix(dayCount()), id: \.date) { forecast in
                VStack(alignment: .leading, spacing: 5) {
                   Text(forecast.date)
                        .font(widgetFamily == .systemSmall ? .caption : .subheadline)
                        .foregroundColor(.white)
                    ForEach(forecast.details, id: \.type) { detail in
                        PollenDetailRow(level: detail.level, type: detail.type)
                    }
                }.padding(.vertical)
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical)
        .background(Color.black.opacity(0.8))
        .cornerRadius(8)
    }
    
    func dayCount() -> Int {
        switch widgetFamily {
        case .systemSmall:
            return 1  // 1 day for small widget
        case .systemMedium:
            return 2  // 2 days for medium widget
        case .systemLarge:
            return 4  // 4 days for large widget
        default:
            return 1
        }
    }
}

struct DailyPollenForecast {
    let date: String
    let details: [PollenDetail]
}

struct PollenDetail {
    let type: PollenDetailRow.PollenType
    let level: Double
}


struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(alignment: .center, spacing: 6) {
                Image(systemName: "circle.hexagongrid")
                    .foregroundStyle(.white)
                    .frame(width: 24, height: 24)
                Text("Pollen Forecast")
                    .font(.title)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                Spacer()
            }
            PollenForecastView(maxRows: 7)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .shadow(radius: 5)
                .padding([.leading, .trailing])
            
            HStack(alignment: .center, spacing: 6) {
                Image(systemName: "allergens")
                    .foregroundStyle(.white)
                    .frame(width: 24, height: 24)
                Text("Detailed Forecast")
                    .font(.title2)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                Spacer()
            }
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(SampleData.generate(), id: \.date) { detail in
                        PollenDayView(forecasts: [detail]) // Pass only the current day
                            .padding([.leading, .trailing], 5)
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}


extension WidgetFamily: EnvironmentKey {
    public static var defaultValue: WidgetFamily = .systemSmall
}

extension EnvironmentValues {
    var widgetFamily: WidgetFamily {
        get { self[WidgetFamily.self] }
        set { self[WidgetFamily.self] = newValue }
    }
}
