//
//  DecodableExtensions.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import Foundation

extension Decodable where Self == Data {
    
    func decoded<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
    
}
