//
//  Ticker.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import Foundation

struct Ticker: Decodable {
    let channelID: Int
    let bid: Double
    let bidSize: Double
    let ask: Double
    let askSize: Double
    let dailyChange: Double
    let dailyChangePerc: Double
    let lastPrice: Double
    let volume: Double
    let high: Double
    let low: Double
}

extension Ticker {
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        channelID = try container.decode(Int.self)
        bid = try container.decode(Double.self)
        bidSize = try container.decode(Double.self)
        ask = try container.decode(Double.self)
        askSize = try container.decode(Double.self)
        dailyChange = try container.decode(Double.self)
        dailyChangePerc = try container.decode(Double.self)
        lastPrice = try container.decode(Double.self)
        volume = try container.decode(Double.self)
        high = try container.decode(Double.self)
        low = try container.decode(Double.self)
    }
    
}
