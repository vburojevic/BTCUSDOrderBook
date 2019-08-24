//
//  OrderBookUpdate.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import Foundation

struct OrderBookUpdate: Decodable {
    
    // MARK: - Public properties -
    
    let channelId: Int
    let price: Float
    let count: Float
    let amount: Float
    
    // MARK: - Lifecycle -
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        channelId = try container.decode(Int.self)
        price = try container.decode(Float.self)
        count = try container.decode(Float.self)
        amount = try container.decode(Float.self)
    }
    
}
