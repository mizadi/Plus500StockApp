//
//  FeedWithTimestampAndRate.swift
//  Plus500StockApp
//
//  Created by Adi Mizrahi on 06/05/2025.
//

import Foundation

struct FeedWithTimestampAndRate: Identifiable {
    let feed: Feed
    let timestamp: Date
    let uniqueId: UUID
    let rate: String
    
    var id: UUID { uniqueId }
}
