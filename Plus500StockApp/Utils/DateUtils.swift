//
//  DateUtils.swift
//  Plus500StockApp
//
//  Created by Adi Mizrahi on 06/05/2025.
//

import Foundation

final class DateUtils {
    static let shared = DateUtils()
    
    private init() {}
    
    lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
}
