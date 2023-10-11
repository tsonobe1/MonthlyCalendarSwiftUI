//
//  Item.swift
//  Calender
//
//  Created by tsonobe on 2023/10/11.
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
