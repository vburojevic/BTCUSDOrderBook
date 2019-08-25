//
//  OrderBookSnapshot.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import Foundation

struct OrderBookSnapshot: Decodable {
    let channelId: Int
    let orderBooks: [OrderBook]
}

extension OrderBookSnapshot {
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        channelId = try container.decode(Int.self)
        orderBooks = try container.decode([OrderBook].self)
    }
    
}
