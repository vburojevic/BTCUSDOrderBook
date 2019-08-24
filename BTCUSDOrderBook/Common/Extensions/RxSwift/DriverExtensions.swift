//
//  DriverExtensions.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {
    
    func mapTo<Element>(_ value: Element) -> Driver<Element> {
        return map { _ in value }
    }
    
}
