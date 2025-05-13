//
//  StockDetailViewModelFactory.swift
//  Plus500StockApp
//
//  Created by Adi Mizrahi on 06/05/2025.
//

import Foundation

@MainActor
class StockDetailViewModelFactory {
    static func createViewModel(stock: Stock, feed: Feed?, service: Plus500ApiService) -> StockDetailViewModel {
        let feed = feed ?? Feed(
            id: stock.id,
            buyPrice: 0.0,
            sellPrice: 0.0,
            precisionDigit: stock.precisionDigit
        )
        
        let feedWithTime = FeedWithTimestampAndRate(
            feed: feed, 
            timestamp: Date(), 
            uniqueId: UUID(), 
            rate: "0"
        )
        
        return StockDetailViewModel(
            stock: stock,
            service: service,
            initialFeed: feedWithTime
        )
    }
}
