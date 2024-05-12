//
//  Item.swift
//  pollenView
//
//  Created by Sam Roman on 5/12/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
