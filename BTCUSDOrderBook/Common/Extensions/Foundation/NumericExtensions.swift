//
//  NumericExtensions.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import Foundation

extension Numeric {
    
    var asMoney: String {
        return MoneyFormatter.instance.money(from: self as! NSNumber)
    }
    
}
