//
//  MoneyFormatter.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import Foundation

final class MoneyFormatter: NumberFormatter {
    
    // MARK: - Singleton -
    
    static let instance = MoneyFormatter()
    
    // MARK: - Lifecycle -
    
    override init() {
        super.init()
        locale = Locale(identifier: "en_US_POSIX")
        numberStyle = .currency
        usesGroupingSeparator = true
        positiveFormat = "¤#,##0.0"
        negativeFormat = "-¤#,##0.0"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Override -
    
    func money(from number: NSNumber) -> String {
        return super.string(from: number) ?? "N/A"
    }
    
    // MARK: - Public functions -
    
    func money(from number: Double) -> String {
        return money(from: NSNumber(value: number))
    }
    
}
