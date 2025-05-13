//
//  StockDetailView.swift
//  Plus500StockApp
//
//  Created by Adi Mizrahi on 06/05/2025.
//


import SwiftUI

struct StockDetailView: View {
    let stock: Stock
    @StateObject private var viewModel: StockDetailViewModel

    init(stock: Stock, feed: Feed?, service: Plus500ApiService) {
            self.stock = stock
            self._viewModel = StateObject(wrappedValue: StockDetailViewModelFactory.createViewModel(
                stock: stock,
                feed: feed,
                service: service
            ))
        }

    var body: some View {
        VStack {
            Text("Stock Name: \(stock.name)")
                .font(.largeTitle)
                .padding()

            Text("Stock Symbol: \(stock.symbol)")
                .font(.title)
                .foregroundColor(.gray)
                .padding(.bottom, 30)

            List {
                ForEach(viewModel.feedData) { feedWithRate in
                    FeedRowView(feedWithRate: feedWithRate)
                }
            }
        }
        .navigationTitle(stock.name)
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            viewModel.stopUpdates()
        }
    }
}
