//
//  HomeCellItem.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import Foundation

struct HomeCellItem {
    let buyPrice: String
    let buyAmount: String
    let sellPrice: String
    let sellAmount: String
}

extension HomeCellItem {
    
    init(buyOrderBook: OrderBook, sellOrderBook: OrderBook) {
        buyPrice = String(format: "%.1f", buyOrderBook.price)
        buyAmount = String(buyOrderBook.amount)
        sellPrice = String(format: "%.1f", abs(sellOrderBook.amount))
        sellAmount = String(abs(sellOrderBook.amount))
    }
    
}
