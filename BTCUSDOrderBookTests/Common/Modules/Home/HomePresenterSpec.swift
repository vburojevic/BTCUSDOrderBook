//
//  HomePresenterSpec.swift
//  BTCUSDOrderBookTests
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

@testable import BTCUSDOrderBook
import Quick
import Nimble
import RxSwift
import RxCocoa
import RxBlocking

final class HomePresenterSpec: QuickSpec {
    
    override func spec() {
        
        var wireframe: HomeWireframeInterfaceSpy!
        var view: HomeViewInterfaceSpy!
        var interactor: HomeInteractorInterfaceSpy!
        var presenter: HomePresenter!
        
        var input: HomeViewInput!
        var headerItem: Driver<HomeHeaderViewItem>!
        var isHeaderIndicatorAnimating: Driver<Bool>!
        var isHeaderHidden: Driver<Bool>!
        var cellItems: Driver<[HomeCellItem]>!
        var isTableIndicatorAnimating: Driver<Bool>!
        var isTableHidden: Driver<Bool>!
        
        beforeEach {
            wireframe = HomeWireframeInterfaceSpy()
            view = HomeViewInterfaceSpy()
            interactor = HomeInteractorInterfaceSpy()
            presenter = HomePresenter(wireframe: wireframe, view: view, interactor: interactor)
            input = presenter.setup(with: HomeViewOutput())
            headerItem = input.headerItem
            isHeaderIndicatorAnimating = input.isHeaderIndicatorAnimating
            isHeaderHidden = input.isHeaderHidden
            cellItems = input.cellItems
            isTableIndicatorAnimating = input.isHeaderIndicatorAnimating
            isTableHidden = input.isHeaderHidden
        }
        
        describe("presenter socket connection") {
            it("should try to connect to the socket when module becomes active", closure: {
                expect(interactor.invokedConnect).to(beTruthy())
            })
        }
        
        describe("header item", {
            it("should be correctly configured", closure: {
                expect(headerItem).array.to(equal([
                    HomeHeaderViewItem(pair: "BTCUSD", lastValue: "LAST: $3,233.7", volume: "VOL: 128.760", dailyChangePercentage: "0.98 %", dailyChangePercentageColor: .primary, low: "LOW: $6,321.2", high: "HIGH: $7,622.2"),
                    HomeHeaderViewItem(pair: "BTCUSD", lastValue: "LAST: $15,333.7", volume: "VOL: 12338.760", dailyChangePercentage: "-2.08 %", dailyChangePercentageColor: .error, low: "LOW: $68,321.2", high: "HIGH: $97,622.2"),
                    HomeHeaderViewItem(pair: "BTCUSD", lastValue: "LAST: $19,633.7", volume: "VOL: 9338.760", dailyChangePercentage: "12.08 %", dailyChangePercentageColor: .primary, low: "LOW: $681.2", high: "HIGH: $3,422.2")
                ]))
            })
        })
        
        describe("header loading indicator") {
            it("should be loading according to the loaded header state", closure: {
                expect(isHeaderIndicatorAnimating).array.to(equal([
                    true,
                    false
                ]))
            })
        }
        
        describe("header hidden state") {
            it("should be hidden according to the loaded header state", closure: {
                expect(isHeaderHidden).array.to(equal([
                    true,
                    false
                ]))
            })
        }
        
        describe("cell items", {
            it("should be correctly updated according to the latest order books state", closure: {
                expect(cellItems).array.to(equal([
                    [
                        HomeCellItem(buyPrice: "23.2", buyAmount: "232.69", sellPrice: "2.9", sellAmount: "2.86"),
                        HomeCellItem(buyPrice: "98.9", buyAmount: "846.456", sellPrice: "2.9", sellAmount: "2.86")
                    ],
                    [
                        HomeCellItem(buyPrice: "23.2", buyAmount: "232.69", sellPrice: "93.1", sellAmount: "93.12877"),
                        HomeCellItem(buyPrice: "98.9", buyAmount: "846.456", sellPrice: "2.9", sellAmount: "2.86"),
                        HomeCellItem(buyPrice: "98.9", buyAmount: "846.456", sellPrice: "2.9", sellAmount: "2.86")
                    ],
                    [
                        HomeCellItem(buyPrice: "23.2", buyAmount: "232.69", sellPrice: "2343.1", sellAmount: "2343.1234"),
                        HomeCellItem(buyPrice: "98.9", buyAmount: "846.456", sellPrice: "93.1", sellAmount: "93.12877"),
                        HomeCellItem(buyPrice: "98.9", buyAmount: "846.456", sellPrice: "2.9", sellAmount: "2.86")
                    ],
                    [
                        HomeCellItem(buyPrice: "2.8", buyAmount: "71223.21323", sellPrice: "2343.1", sellAmount: "2343.1234"),
                        HomeCellItem(buyPrice: "23.2", buyAmount: "232.69", sellPrice: "93.1", sellAmount: "93.12877"),
                        HomeCellItem(buyPrice: "98.9", buyAmount: "846.456", sellPrice: "2.9", sellAmount: "2.86"),
                        HomeCellItem(buyPrice: "98.9", buyAmount: "846.456", sellPrice: "2.9", sellAmount: "2.86")
                    ],
                    [
                        HomeCellItem(buyPrice: "323.2", buyAmount: "0.1289979", sellPrice: "2343.1", sellAmount: "2343.1234"),
                        HomeCellItem(buyPrice: "2.8", buyAmount: "71223.21323", sellPrice: "93.1", sellAmount: "93.12877"),
                        HomeCellItem(buyPrice: "23.2", buyAmount: "232.69", sellPrice: "2.9", sellAmount: "2.86"),
                        HomeCellItem(buyPrice: "98.9", buyAmount: "846.456", sellPrice: "2.9", sellAmount: "2.86")
                    ],
                    [
                        HomeCellItem(buyPrice: "67523.1", buyAmount: "812386.121239", sellPrice: "2343.1", sellAmount: "2343.1234"),
                        HomeCellItem(buyPrice: "323.2", buyAmount: "0.1289979", sellPrice: "93.1", sellAmount: "93.12877"),
                        HomeCellItem(buyPrice: "2.8", buyAmount: "71223.21323", sellPrice: "2.9", sellAmount: "2.86"),
                        HomeCellItem(buyPrice: "23.2", buyAmount: "232.69", sellPrice: "2.9", sellAmount: "2.86")
                    ],
                    [
                        HomeCellItem(buyPrice: "67523.1", buyAmount: "812386.121239", sellPrice: "613.8", sellAmount: "613.78261"),
                        HomeCellItem(buyPrice: "323.2", buyAmount: "0.1289979", sellPrice: "2343.1", sellAmount: "2343.1234"),
                        HomeCellItem(buyPrice: "2.8", buyAmount: "71223.21323", sellPrice: "93.1", sellAmount: "93.12877"),
                        HomeCellItem(buyPrice: "23.2", buyAmount: "232.69", sellPrice: "2.9", sellAmount: "2.86"),
                        HomeCellItem(buyPrice: "98.9", buyAmount: "846.456", sellPrice: "2.9", sellAmount: "2.86")
                    ],
                    [
                        HomeCellItem(buyPrice: "321.2", buyAmount: "8174387.21", sellPrice: "613.8", sellAmount: "613.78261"),
                        HomeCellItem(buyPrice: "67523.1", buyAmount: "812386.121239", sellPrice: "2343.1", sellAmount: "2343.1234"),
                        HomeCellItem(buyPrice: "323.2", buyAmount: "0.1289979", sellPrice: "93.1", sellAmount: "93.12877"),
                        HomeCellItem(buyPrice: "2.8", buyAmount: "71223.21323", sellPrice: "2.9", sellAmount: "2.86"),
                        HomeCellItem(buyPrice: "23.2", buyAmount: "232.69", sellPrice: "2.9", sellAmount: "2.86")
                    ],
                    [
                        HomeCellItem(buyPrice: "321.2", buyAmount: "8174387.21", sellPrice: "1231242.3", sellAmount: "1231242.32789"),
                        HomeCellItem(buyPrice: "67523.1", buyAmount: "812386.121239", sellPrice: "613.8", sellAmount: "613.78261"),
                        HomeCellItem(buyPrice: "323.2", buyAmount: "0.1289979", sellPrice: "2343.1", sellAmount: "2343.1234"),
                        HomeCellItem(buyPrice: "2.8", buyAmount: "71223.21323", sellPrice: "93.1", sellAmount: "93.12877"),
                        HomeCellItem(buyPrice: "23.2", buyAmount: "232.69", sellPrice: "2.9", sellAmount: "2.86"),
                        HomeCellItem(buyPrice: "98.9", buyAmount: "846.456", sellPrice: "2.9", sellAmount: "2.86")
                    ],
                    [
                        HomeCellItem(buyPrice: "321.2", buyAmount: "8174387.21", sellPrice: "21421.3", sellAmount: "21421.32789"),
                        HomeCellItem(buyPrice: "67523.1", buyAmount: "812386.121239", sellPrice: "1231242.3", sellAmount: "1231242.32789"),
                        HomeCellItem(buyPrice: "323.2", buyAmount: "0.1289979", sellPrice: "613.8", sellAmount: "613.78261"),
                        HomeCellItem(buyPrice: "2.8", buyAmount: "71223.21323", sellPrice: "2343.1", sellAmount: "2343.1234"),
                        HomeCellItem(buyPrice: "23.2", buyAmount: "232.69", sellPrice: "93.1", sellAmount: "93.12877"),
                        HomeCellItem(buyPrice: "98.9", buyAmount: "846.456", sellPrice: "2.9", sellAmount: "2.86"),
                        HomeCellItem(buyPrice: "98.9", buyAmount: "846.456", sellPrice: "2.9", sellAmount: "2.86")
                    ],
                    [
                        HomeCellItem(buyPrice: "321.2", buyAmount: "8174387.21", sellPrice: "0.3", sellAmount: "0.32789"),
                        HomeCellItem(buyPrice: "67523.1", buyAmount: "812386.121239", sellPrice: "21421.3", sellAmount: "21421.32789"),
                        HomeCellItem(buyPrice: "323.2", buyAmount: "0.1289979", sellPrice: "1231242.3", sellAmount: "1231242.32789"),
                        HomeCellItem(buyPrice: "2.8", buyAmount: "71223.21323", sellPrice: "613.8", sellAmount: "613.78261"),
                        HomeCellItem(buyPrice: "23.2", buyAmount: "232.69", sellPrice: "2343.1", sellAmount: "2343.1234"),
                        HomeCellItem(buyPrice: "98.9", buyAmount: "846.456", sellPrice: "93.1", sellAmount: "93.12877"),
                        HomeCellItem(buyPrice: "98.9", buyAmount: "846.456", sellPrice: "2.9", sellAmount: "2.86")
                    ]
                ]))
            })
        })
        
        describe("table loading indicator") {
            it("should be loading according to the loaded table state", closure: {
                expect(isTableIndicatorAnimating).array.to(equal([
                    true,
                    false
                ]))
            })
        }
        
        describe("table hidden state") {
            it("should be hidden according to the loaded table state", closure: {
                expect(isTableHidden).array.to(equal([
                    true,
                    false
                ]))
            })
        }
        
    }
    
}
