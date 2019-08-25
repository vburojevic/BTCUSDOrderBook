//
//  OrderBookUpdate.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import Foundation

struct OrderBookUpdate: Decodable {
    let channelId: Int
    let price: Double
    let count: Double
    let amount: Double
}

extension OrderBookUpdate {
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        channelId = try container.decode(Int.self)
        price = try container.decode(Double.self)
        count = try container.decode(Double.self)
        amount = try container.decode(Double.self)
    }
    
}
