//
//  StockDetailViewModel.swift
//  Plus500StockApp
//
//  Created by Adi Mizrahi on 06/05/2025.
//

import SwiftUI

@MainActor
class StockDetailViewModel: ObservableObject {
    private nonisolated let feedsUpdater: FeedsUpdater
    @Published var feedData: [FeedWithTimestampAndRate] = []
    private let maxRows = 5
    private var isActive = true
    private var stock: Stock


    func addInitialFeed(_ feed: FeedWithTimestampAndRate) {
        feedData.insert(feed, at: 0)
    }

    init(stock: Stock, service: Plus500ApiService, initialFeed: FeedWithTimestampAndRate) {
        self.stock = stock
        self.feedsUpdater = FeedsUpdater(apiService: service)
        feedsUpdater.updateStockPrecisions([stock])
        self.feedsUpdater.stopUpdating()
        self.feedsUpdater.startUpdatingFeeds(stockIds: [stock.id] )
        self.feedData.append(initialFeed)
        self.feedsUpdater.onFeedsUpdate = { [weak self] newFeeds in
            guard let self = self, self.isActive else { return }
            let stockFeeds = newFeeds.filter { $0.id == stock.id }

            Task { @MainActor in
                let timestampedFeeds = stockFeeds.map { feed in
                    let rate = self.calculateRate(currentFeed: feed,
                                                  previousFeed: self.feedData.first?.feed)
                    return FeedWithTimestampAndRate(
                        feed: feed,
                        timestamp: Date(),
                        uniqueId: UUID(),
                        rate: rate
                    )
                }
                var updatedFeeds = timestampedFeeds + self.feedData

                if updatedFeeds.count > self.maxRows {
                    updatedFeeds = Array(updatedFeeds.prefix(self.maxRows))
                }

                self.feedData = updatedFeeds
            }
        }
    }

    private func calculateRate(currentFeed: Feed, previousFeed: Feed?) -> String {
        guard let previousFeed = previousFeed else { return "0" }
        let difference = currentFeed.sellPrice - previousFeed.sellPrice
        return String(format: "%.\(stock.precisionDigit)f", difference)
    }

    func stopUpdates() {
        feedsUpdater.stopUpdating()
        feedsUpdater.onFeedsUpdate = nil
    }
}
