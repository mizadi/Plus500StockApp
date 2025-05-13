//
//  NetworkServicing.swift
//  Plus500StockApp
//
//  Created by Adi Mizrahi on 06/05/2025.
//

import Foundation

protocol NetworkServicing {
    func perform<T: Decodable>(_ request: URLRequest) async throws -> T
}
