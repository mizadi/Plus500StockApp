//
//  Stock.swift
//  Plus500StockApp
//
//  Created by Adi Mizrahi on 06/05/2025.
//

struct Stock: Identifiable, Codable, Hashable {
    let id: Int
    let symbol: String
    let name: String
    let precisionDigit: Int

    var buyPrice: Double?
    var sellPrice: Double?

    enum CodingKeys: String, CodingKey {
        case Id
        case Symbol
        case Name
        case PrecisionDigit
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys .self)
        id = try container.decodeIfPresent(Int.self, forKey: .Id) ?? 0
        symbol = try container.decodeIfPresent(String.self, forKey: .Symbol) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .Name) ?? ""
        precisionDigit = try container.decodeIfPresent(Int.self, forKey: .PrecisionDigit) ?? 0
    }

    func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .Id)
            try container.encode(symbol, forKey: .Symbol)
            try container.encode(name, forKey: .Name)
            try container.encode(precisionDigit, forKey: .PrecisionDigit)
        }
}
