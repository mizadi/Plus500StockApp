//
//  NetworkServicing.swift
//  Plus500StockApp
//
//  Created by Adi Mizrahi on 06/05/2025.
//

import Foundation

class NetworkService: NetworkServicing {
    func perform<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
