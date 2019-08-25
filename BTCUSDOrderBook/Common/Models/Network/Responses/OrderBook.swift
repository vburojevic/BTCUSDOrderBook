//
//  OrderBook.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import Foundation

struct OrderBook: Decodable {
    let price: Double
    let count: Double
    let amount: Double
}

extension OrderBook {
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        price = try container.decode(Double.self)
        count = try container.decode(Double.self)
        amount = try container.decode(Double.self)
    }
    
    init(orderBookUpdate: OrderBookUpdate) {
        price = orderBookUpdate.price
        count = orderBookUpdate.count
        amount = orderBookUpdate.amount
    }
    
}
