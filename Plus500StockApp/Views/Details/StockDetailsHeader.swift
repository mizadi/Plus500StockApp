//
//  StockDetailsHeader.swift
//  Plus500StockApp
//
//  Created by Adi Mizrahi on 06/05/2025.
//

import SwiftUI

struct StockDetailsHeader: View {
    let stock: Stock

    var body: some View {
        VStack(alignment: .leading) {
            Text("Stock Name: \(stock.name)")
                .font(.largeTitle)
                .padding()

            Text("Stock Symbol: \(stock.symbol)")
                .font(.title)
                .foregroundColor(.gray)
                .padding(.bottom, 30)
        }
    }
}
