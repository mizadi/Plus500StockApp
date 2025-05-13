//
//  MainView.swift
//  Plus500StockApp
//
//  Created by Adi Mizrahi on 06/05/2025.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var selectedStock: Stock?

    var body: some View {
        NavigationStack {
            List(viewModel.stockData) { stock in
                Button {
                    selectedStock = stock
                } label: {
                    StockRow(stock: stock, feed: viewModel.feedLookup[stock.id])
                }
            }
            .navigationDestination(item: $selectedStock) { stock in
                StockDetailView(stock: stock, feed: viewModel.feedLookup[stock.id], service: viewModel.apiservice)
            }
            .navigationTitle("Stocks")
        }.task {
            viewModel.startFeedsUpdater()
        }
    }
}
