//
//  StockRow.swift
//  Plus500StockApp
//
//  Created by Adi Mizrahi on 06/05/2025.
//

import SwiftUI

struct StockRow: View {
    let stock: Stock
    let feed: Feed?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(stock.name)
                .font(.headline)
            Text(stock.symbol)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let feed = feed {
                Text("Buy: \(feed.formattedBuyPrice)")
                    .font(.subheadline)
                    .foregroundColor(.green)
                Text("Sell: \(feed.formattedSellPrice)")
                    .font(.subheadline)
                    .foregroundColor(.red)
            } else {
                Text("No feed data")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 4)
    }
}
