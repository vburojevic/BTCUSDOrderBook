//
//  MoneyFormatterSpec.swift
//  BTCUSDOrderBookTests
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

@testable import BTCUSDOrderBook
import Quick
import Nimble

final class MoneyFormatterSpec: QuickSpec {
    
    override func spec() {
        describe("money formatter") {
            it("correctly formats strings from numbers") {
                expect(12.80.asMoney).to(equal("$12.8"))
                expect(1337.765.asMoney).to(equal("$1,337.8"))
                expect(0.asMoney).to(equal("$0.0"))
                expect(999.asMoney).to(equal("$999.0"))
                expect(53653333.45.asMoney).to(equal("$53,653,333.4"))
            }
        }
    }
    
}
