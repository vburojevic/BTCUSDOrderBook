//
//  HomeInteractorInterfaceSpy.swift
//  BTCUSDOrderBookTests
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

@testable import BTCUSDOrderBook
import Foundation
import RxSwift

final class HomeInteractorInterfaceSpy: HomeInteractorInterface {
    
    var isConnected: Observable<Bool> {
        return Observable.from([true])
    }
    
    var ticker: Observable<Ticker> {
        return Observable.from([
            Ticker(channelID: 1, bid: 20.76, bidSize: 25.21, ask: 34.21, askSize: 123.23, dailyChange: 43.21, dailyChangePerc: 0.98, lastPrice: 3233.7, volume: 128.76, high: 7622.23, low: 6321.22),
            Ticker(channelID: 2, bid: 90.76, bidSize: 87.21, ask: 90.21, askSize: 75.23, dailyChange: 2332.21, dailyChangePerc: -2.08, lastPrice: 15333.7, volume: 12338.76, high: 97622.23, low: 68321.22),
            Ticker(channelID: 3, bid: 290.76, bidSize: 37.21, ask: 720.21, askSize: 715.23, dailyChange: 23232.21, dailyChangePerc: 12.08, lastPrice: 19633.7, volume: 9338.76, high: 3422.23, low: 681.22)
        ])
    }
    
    var orderBookSnapshot: Observable<OrderBookSnapshot> {
        return Observable.from([OrderBookSnapshot(channelId: 1, orderBooks: [
            OrderBook(price: 23.21, count: 3, amount: 232.69),
            OrderBook(price: 11.26, count: 9, amount: -2.86),
            OrderBook(price: 98.87, count: 3, amount: 846.456),
            OrderBook(price: 87.26, count: 9, amount: -2.86),
            OrderBook(price: 98.87, count: 3, amount: 846.456)
        ])])
    }
    
    var orderBookUpdate: Observable<OrderBookUpdate> {
        return Observable.from([
            OrderBookUpdate(channelId: 1, price: 732.213, count: 1, amount: -93.12877),
            OrderBookUpdate(channelId: 1, price: 53496.34287, count: 123, amount: -2343.1234),
            OrderBookUpdate(channelId: 1, price: 2.79321, count: 2, amount: 71223.21323),
            OrderBookUpdate(channelId: 1, price: 323.213, count: 12, amount: 0.1289979),
            OrderBookUpdate(channelId: 1, price: 67523.12, count: 14, amount: 812386.121239),
            OrderBookUpdate(channelId: 1, price: 12.123, count: 13, amount: -613.78261),
            OrderBookUpdate(channelId: 1, price: 321.231, count: 11, amount: 8174387.21),
            OrderBookUpdate(channelId: 1, price: 6534.14, count: 133, amount: -1231242.327890),
            OrderBookUpdate(channelId: 1, price: 93473.2, count: 122, amount: -21421.327890),
            OrderBookUpdate(channelId: 1, price: 32142.3, count: 231, amount: -0.327890)
        ])
    }
    
    var invokedConnect = false
    var invokedConnectCount = 0
    
    func connect() {
        invokedConnect = true
        invokedConnectCount += 1
    }
    
}
