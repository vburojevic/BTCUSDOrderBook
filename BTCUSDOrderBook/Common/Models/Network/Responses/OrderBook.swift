//
//  OrderBook.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import Foundation

struct OrderBook: Decodable {
    
    // MARK: - Public properties -
    
    let price: Float
    let count: Float
    let amount: Float
    
    // MARK: - Lifecycle -
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        price = try container.decode(Float.self)
        count = try container.decode(Float.self)
        amount = try container.decode(Float.self)
    }
    
}

extension OrderBook {
    
    init(orderBookUpdate: OrderBookUpdate) {
        price = orderBookUpdate.price
        count = orderBookUpdate.count
        amount = orderBookUpdate.amount
    }
    
}
