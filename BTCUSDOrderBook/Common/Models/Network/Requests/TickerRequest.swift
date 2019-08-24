//
//  TickerRequest.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import Foundation

struct TickerRequest: Encodable {
    let event: String
    let channel: String
    let pair: String
}
