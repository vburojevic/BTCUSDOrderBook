//
//  ExpectationExtensions.swift
//  BTCUSDOrderBookTests
//
//  Created by Vedran Burojevic on 25/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import Foundation
import Nimble
import RxSwift
import RxBlocking

extension Expectation {
    
    internal func transform<U>(_ closure: @escaping (T?) throws -> U?) -> Expectation<U> {
        let expression = self.expression.cast(closure)
        return Expectation<U>(expression: expression)
    }
    
}

extension Expectation where T: ObservableConvertibleType {
    
    var first: Expectation<T.Element> {
        return transform { source in
            try source?.toBlocking().first()
        }
    }
    
    var last: Expectation<T.Element> {
        return transform { source in
            try source?.toBlocking().last()
        }
    }
    
    var array: Expectation<[T.Element]> {
        return transform { source in
            try source?.toBlocking().toArray()
        }
    }
    
}
