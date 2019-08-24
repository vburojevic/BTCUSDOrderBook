//
//  EncodableExtensions.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import Foundation

extension Encodable {
    
    var dictionary: [String: Any]? {
        guard let data = data else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
            .flatMap { $0 as? [String: Any] }
    }
    
    var data: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    var utf8String: String? {
        return data.flatMap { String(data: $0, encoding: .utf8) }
    }
    
}
