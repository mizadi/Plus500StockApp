//
//  FeedRowView.swift
//  Plus500StockApp
//
//  Created by Adi Mizrahi on 06/05/2025.
//

import SwiftUI


struct FeedRowView: View {
    let feedWithRate: FeedWithTimestampAndRate

    var body: some View {
        HStack {
            Text(DateUtils.shared.timeFormatter.string(from: feedWithRate.timestamp))
                .foregroundColor(.gray)
                .font(.system(.body, design: .monospaced))
            Spacer()
            Text("Buy: \(feedWithRate.feed.formattedBuyPrice)")
            Spacer()
            Text("Sell: \(feedWithRate.feed.formattedSellPrice)")
            Spacer()
            Text("Spread: \(feedWithRate.feed.formattedSpread)")
                .foregroundColor(.secondary)
            Spacer()
            Text("Rate: \(feedWithRate.rate)")
                .foregroundColor(rateColor)
        }
        .padding(.vertical, 8)
    }
    
    private var rateColor: Color {
        if let rateValue = Double(feedWithRate.rate), abs(rateValue) < 0.000001 {
            return .primary
        }
        return (Double(feedWithRate.rate) ?? 0 > 0) ? .green : .red
    }
}
