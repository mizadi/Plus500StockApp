//
//  MainViewModel.swift
//  Plus500StockApp
//
//  Created by Adi Mizrahi on 06/05/2025.
//

import SwiftUI

@MainActor
class MainViewModel: ObservableObject {
    let apiservice: Plus500ApiService
    let feedsUpdater: FeedsUpdater
    @Published var stockData: [Stock] = []
    @Published var feedsData: [Feed] = []
    var feedLookup: [Int: Feed] {
        Dictionary(uniqueKeysWithValues: feedsData.map { ($0.id, $0) })
    }
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    init(service: Plus500ApiService = Plus500ApiService()) {
        self.apiservice = service
        self.feedsUpdater = FeedsUpdater(apiService: service)  // Reuse the same service instance

        Task {
            await fetchStocks()
        }
    }

    func fetchStocks() async {
        isLoading = true
        errorMessage = nil
        do {
            let stocks = try await apiservice.fetchStocks()
            stockData = stocks
            let stockIds = stocks.map { $0.id }
            feedsUpdater.updateStockPrecisions(stocks)
            feedsUpdater.startUpdatingFeeds(stockIds: stockIds)
        } catch {
            errorMessage = "Failed to load stocks: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func startFeedsUpdater() {
        self.feedsUpdater.stopUpdating()
            self.feedsUpdater.onFeedsUpdate = { [weak self] newFeeds in
                if self?.feedsData != newFeeds {
                    DispatchQueue.main.async {
                        self?.feedsData = newFeeds
                    }
                }
            }
        let stockIds = stockData.map { $0.id }
        feedsUpdater.updateStockPrecisions(stockData)
        feedsUpdater.startUpdatingFeeds(stockIds: stockIds)
    }

    deinit {
        feedsUpdater.stopUpdating()
    }
}
