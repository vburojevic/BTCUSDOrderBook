//
//  HomeHeaderViewItem.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import UIKit

struct HomeHeaderViewItem {
    let pair: String
    let lastValue: String
    let volume: String
    let dailyChangePercentage: String
    let dailyChangePercentageColor: UIColor
    let low: String
    let high: String
}

extension HomeHeaderViewItem {
    
    init(pairName: String, ticker: Ticker) {
        pair = pairName
        lastValue = Strings.last.localized.uppercased() + ": " + MoneyFormatter.instance.string(from: ticker.lastPrice)
        volume = Strings.volumeAbbreviation.localized.uppercased() + ": " + String(format: "%.3f", ticker.volume)
        dailyChangePercentage = String(format: "%.2f", ticker.dailyChangePerc) + " %"
        dailyChangePercentageColor = ticker.dailyChangePerc < 0 ? .error : .primary
        low = Strings.low.localized.uppercased() + ": " + MoneyFormatter.instance.string(from: ticker.low)
        high = Strings.high.localized.uppercased() + ": " + MoneyFormatter.instance.string(from: ticker.high)
    }
    
}
