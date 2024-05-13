//
//  PollenForecastView.swift
//  pollenView
//
//  Created by Sam Roman on 5/12/24.
//
//

import SwiftUI

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
    
    private var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let maxRows: Int
    
    public init(maxRows: Int = 7) {
        self.maxRows = maxRows
    }
    
    public var body: some View {
        VStack {
            Text("Pollen Forecast")
                .font(.headline)
                .padding(.bottom, 8)
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(forecasts.prefix(maxRows), id: \.date) { forecast in
                    VStack(spacing: 4) {
                        PollenIndicator(level: forecast.level)
                        Text(forecast.date)
                            .font(.caption)
                    }
                }
            }
        }
        .padding()
    }
}

public struct PollenForecast {
    public let date: String
    public let level: Int // 1 - 9
    
    public init(date: String, level: Int) {
        self.date = date
        self.level = level
    }
}

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
                        .shadow(color: shadowColorForLevel(row * 2 + 1), radius: 4)
                    Circle()
                        .fill(row * 2 + 2 <= level ? colorForLevel(row * 2 + 2) : Color.gray)
                        .frame(width: 12, height: 12)
                        .shadow(color: shadowColorForLevel(row * 2 + 2), radius: 4)
                }
            }
        }
    }
    
    func colorForLevel(_ level: Int) -> Color {
        // Define a gradient that ranges from green to yellow to orange to red
        let gradientColors = [Color.green, Color.yellow, Color.orange, Color.red]
        
        let stops = gradientColors.count - 1
        let position = Double(level - 1) / Double(maxDots - 1)
        
        let index = Int(position * Double(stops))
        let lowerColor = gradientColors[index]
        let upperColor = gradientColors[min(index + 1, stops)]
        
        // Interpolate between the lower and upper colors
        let ratio = position * Double(stops) - Double(index)
        let interpolatedColor = mixColors(lowerColor, upperColor, ratio: ratio)
        
        return interpolatedColor
    }
    
    func shadowColorForLevel(_ level: Int) -> Color {
        let baseColor = colorForLevel(level)
        return baseColor.opacity(0.6)
    }
    
    // Helper function to interpolate between two colors
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

struct ContentView: View {
    var body: some View {
        PollenForecastView()
    }
}

