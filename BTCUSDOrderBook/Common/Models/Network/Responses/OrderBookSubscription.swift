//
//  OrderBookSubscription.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import Foundation

struct OrderBookSubscription: Decodable {
    
    // MARK: - Public properties -
    
    let event: String
    let channel: String
    let pair: String
    let chanId: Int
    let prec: String
    let freq: String
    let len: String
    
}
