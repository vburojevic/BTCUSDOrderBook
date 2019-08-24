//
//  Ticker.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import Foundation

struct Ticker: Decodable {
    
    // MARK: - Public properties -
    
    let channelID: Int
    let bid: Float
    let bidSize: Float
    let ask: Float
    let askSize: Float
    let dailyChange: Float
    let dailyChangePerc: Float
    let lastPrice: Float
    let volume: Float
    let high: Float
    let low: Float
    
    // MARK: - Lifecycle -
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        channelID = try container.decode(Int.self)
        bid = try container.decode(Float.self)
        bidSize = try container.decode(Float.self)
        ask = try container.decode(Float.self)
        askSize = try container.decode(Float.self)
        dailyChange = try container.decode(Float.self)
        dailyChangePerc = try container.decode(Float.self)
        lastPrice = try container.decode(Float.self)
        volume = try container.decode(Float.self)
        high = try container.decode(Float.self)
        low = try container.decode(Float.self)
    }
    
}
