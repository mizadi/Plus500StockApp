//
//  Plus500ApiService.swift
//  Plus500StockApp
//
//  Created by Adi Mizrahi on 06/05/2025.
//

import Foundation

class Plus500ApiService {
    private let baseURL = "http://34.159.211.193/api"
    private let networkService: NetworkServicing

    init(networkService: NetworkServicing = NetworkService()) {
        self.networkService = networkService
    }

    private func makeRequest(path: String, queryItems: [URLQueryItem]? = nil) throws -> URLRequest {
        var components = URLComponents(string: baseURL)
        components?.path += path
        components?.queryItems = queryItems

        guard let url = components?.url else {
            throw URLError(.badURL)
        }

        return URLRequest(url: url)
    }

    func fetchStocks() async throws -> [Stock] {
        let request = try makeRequest(path: "/Stock")
        return try await networkService.perform(request)
    }

    func fetchFeeds(ids: [Int]) async throws -> [Feed] {
        let queryItems = [URLQueryItem(name: "ids", value: ids.map(String.init).joined(separator: ","))]
        let request = try makeRequest(path: "/Feeds", queryItems: queryItems)

        let response: FeedsResponse = try await networkService.perform(request)
        return response.feeds.filter { $0.buyPrice.isFinite && $0.sellPrice.isFinite }
    }
}
