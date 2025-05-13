//
//  PriceFormatter.swift
//  Plus500StockApp
//
//  Created by Adi Mizrahi on 06/05/2025.
//


enum PriceFormatter {
    static func format(_ price: Double, precision: Int) -> String {
        return String(format: "%.\(precision)f", price)
    }
    
    static func format(_ price: Double?, precision: Int) -> String {
        guard let price = price else { return "-" }
        return format(price, precision: precision)
    }
}
