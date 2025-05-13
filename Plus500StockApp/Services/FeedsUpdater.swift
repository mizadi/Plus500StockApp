//
//  FeedsUpdater.swift
//  Plus500StockApp
//
//  Created by Adi Mizrahi on 06/05/2025.
//


import Foundation

class FeedsUpdater {
    private let apiService: Plus500ApiService
    private var updateTask: Task<Void, Never>?
    private let updateInterval: UInt64 = 1_000_000_000
    private var stockPrecisions: [Int: Int] = [:]

    var onFeedsUpdate: (([Feed]) -> Void)?

    init(apiService: Plus500ApiService) {
        self.apiService = apiService
    }

    func updateStockPrecisions(_ stocks: [Stock]) {
        stockPrecisions = Dictionary(uniqueKeysWithValues: stocks.map { ($0.id, $0.precisionDigit) })
    }

    func startUpdatingFeeds(stockIds: [Int]) {
        updateTask = Task {
            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: updateInterval)

//                let stockIds = stockIdsProvider()
                guard !stockIds.isEmpty else { continue }

                do {
                    var feeds = try await apiService.fetchFeeds(ids: stockIds)
                    feeds = feeds.map { feed in
                        let precision = stockPrecisions[feed.id] ?? 2 // Default to 2 if not found
                        return Feed(id: feed.id,
                                  buyPrice: feed.buyPrice,
                                  sellPrice: feed.sellPrice, precisionDigit: precision)
                    }
                    onFeedsUpdate?(feeds)
                } catch {
                    if (error as? URLError)?.code != .cancelled {
                        print("Failed to fetch feeds: \(error)")
                    }
                }
            }
        }
    }

    func stopUpdating() {
        updateTask?.cancel()
        updateTask = nil
    }

    deinit {
        stopUpdating()
    }
}
