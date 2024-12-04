//
//  Item.swift
//  SwiftCommits
//
//  Created by Artem Kireev on 02.12.2024.
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