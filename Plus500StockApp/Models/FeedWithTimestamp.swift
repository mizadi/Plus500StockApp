//
//  FeedWithTimestamp.swift
//  Plus500StockApp
//
//  Created by Adi Mizrahi on 06/05/2025.
//

import Foundation

struct FeedWithTimestamp: Identifiable {
    let feed: Feed
    let timestamp: Date
    let uniqueId: UUID
    var id: UUID { uniqueId }

    static func == (lhs: FeedWithTimestamp, rhs: FeedWithTimestamp) -> Bool {
        return lhs.uniqueId == rhs.uniqueId
    }
}
