//
//  Localizable.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import Foundation

protocol Localizable: RawRepresentable {
    var localized: String { get }
    func localized(with args: CVarArg...) -> String
}

extension Localizable where RawValue == String {
    
    var localized: String {
        return self.rawValue.localized
    }
    
    func localized(with args: CVarArg...) -> String {
        return String(format: self.rawValue.localized, arguments: args)
    }
    
}

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
}
