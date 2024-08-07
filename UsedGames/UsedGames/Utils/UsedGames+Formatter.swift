//
//  UsedGames+Formatter.swift
//  UsedGames
//
//  Created by Gulfem ALBAYRAK on 5.08.2024.
//

import Foundation

struct Formatters {
    static let dollarFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.currencyCode = "USD"
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }()
}
