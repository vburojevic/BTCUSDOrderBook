//
//  EncodableExtensionsSpec.swift
//  BTCUSDOrderBookTests
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

@testable import BTCUSDOrderBook
import Quick
import Nimble

final class EncodableExtensionsSpec: QuickSpec {
    
    private struct OrderBookModel: Codable {
        let name: String
        let price: String
        let amount: String
    }
    
    override func spec() {
        describe("encodable dictionary extension") {
            it("should return valid dictionary from the model") {
                let model = OrderBookModel(name: "Name", price: "1337.00", amount: "8008.18")
                
                guard let dictionary = model.dictionary as? [String: String] else {
                    fail("Incorrect dictionary type")
                    return
                }
                
                let validDictionary = [
                    "name": "Name",
                    "price": "1337.00",
                    "amount": "8008.18"
                ]
                
                expect(dictionary).to(equal(validDictionary))
            }
        }
        
        describe("encodable utf8String extension") {
            it("should return valid u from the model") {
                let model = OrderBookModel(name: "Book", price: "54342.23", amount: "0.00")
                
                guard let utf8String = model.utf8String else {
                    fail("Can't convert to string")
                    return
                }
                
                expect(utf8String).to(equal("{\"name\":\"Book\",\"price\":\"54342.23\",\"amount\":\"0.00\"}"))
            }
        }
    }
    
}
