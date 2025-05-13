//
//  FeedsResponse.swift
//  Plus500StockApp
//
//  Created by Adi Mizrahi on 06/05/2025.
//


struct FeedsResponse: Codable {
    let feeds: [Feed]
    let lastUpdate: String

    enum CodingKeys: String, CodingKey {
        case feeds = "Feeds"
        case lastUpdate = "LastUpdate"
    }
}
