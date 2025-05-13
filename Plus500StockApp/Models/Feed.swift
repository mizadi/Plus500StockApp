//
//  Feed.swift
//  Plus500StockApp
//
//  Created by Adi Mizrahi on 06/05/2025.
//


struct Feed: Identifiable, Codable, Equatable {
    let id: Int
    let buyPrice: Double
    let sellPrice: Double
    let precisionDigit: Int

    var formattedBuyPrice: String {
        return PriceFormatter.format(buyPrice, precision: precisionDigit)
    }

    var formattedSellPrice: String {
        return PriceFormatter.format(sellPrice, precision: precisionDigit)
    }

    enum CodingKeys: String, CodingKey {
        case buyPrice = "BuyPrice"
        case sellPrice = "SellPrice"
        case id = "StockId"
    }

    init(id: Int, buyPrice: Double?, sellPrice: Double?, precisionDigit: Int) {
        self.id = id
        self.buyPrice = buyPrice ?? 0
        self.sellPrice = sellPrice ?? 0
        self.precisionDigit = precisionDigit

    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)

        func decodePrice(forKey key: CodingKeys) -> Double {
            if let doubleVal = try? container.decode(Double.self, forKey: key) {
                return doubleVal
            } else if let stringVal = try? container.decode(String.self, forKey: key) {
                return stringVal == "Infinity" ? .infinity : 0
            }
            return 0
        }

        buyPrice = decodePrice(forKey: .buyPrice)
        sellPrice = decodePrice(forKey: .sellPrice)

        precisionDigit = 2 // Default precision digit
    }

    static func ==(lhs: Feed, rhs: Feed) -> Bool {
            return lhs.id == rhs.id && lhs.buyPrice == rhs.buyPrice && lhs.sellPrice == rhs.sellPrice
        }
}
extension Feed {
    var formattedSpread: String {
        let spread = abs(sellPrice - buyPrice)
        return String(format: "%.\(precisionDigit)f", spread)
    }
}
