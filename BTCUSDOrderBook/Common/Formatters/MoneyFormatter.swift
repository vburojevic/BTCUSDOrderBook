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
        maximumFractionDigits = 0
        positiveFormat = "¤#,##0.00"
        negativeFormat = "-¤#,##0.00"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Override -
    
    func string(from number: NSNumber, maximumFractionDigits: Int = 1) -> String {
        self.maximumFractionDigits = maximumFractionDigits
        return super.string(from: number) ?? "N/A"
    }
    
    // MARK: - Public functions -
    
    func string(from number: Float, maximumFractionDigits: Int = 1) -> String {
        return string(from: NSNumber(value: number), maximumFractionDigits: maximumFractionDigits)
    }
    
}
