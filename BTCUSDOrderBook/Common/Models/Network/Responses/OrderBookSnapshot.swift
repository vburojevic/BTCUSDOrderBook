//
//  OrderBookSnapshot.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import Foundation

struct OrderBookSnapshot: Decodable {
    
    // MARK: - Public properties -
    
    let channelId: Int
    let orderBooks: [OrderBook]
    
    // MARK: - Lifecycle -
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        channelId = try container.decode(Int.self)
        orderBooks = try container.decode([OrderBook].self)
    }
    
}
