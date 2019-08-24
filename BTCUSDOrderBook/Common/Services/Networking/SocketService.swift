//
//  SocketService.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import Foundation
import Starscream
import RxSwift
import RxCocoa

protocol SocketServiceable {
    var isConnected: Observable<Bool> { get }
    var orderBookSubscription: Observable<OrderBookSubscription> { get }
    var ticker: Observable<Ticker> { get }
    var orderBookSnapshot: Observable<OrderBookSnapshot> { get }
    var orderBookUpdate: Observable<OrderBookUpdate> { get }
    
    func connect()
}

final class SocketService {
    
    // MARK: - Instance -
    
    static let instance = SocketService()
    
    // MARK: - Public properties -
    
    lazy var isConnected: Observable<Bool> = {
       return self.socket
        .rx
        .connected
    }()
    
    lazy var orderBookSubscription: Observable<OrderBookSubscription> = decodedTextData()
    lazy var ticker: Observable<Ticker> = decodedTextData()
    lazy var orderBookSnapshot: Observable<OrderBookSnapshot> = decodedTextData()
    lazy var orderBookUpdate: Observable<OrderBookUpdate> = decodedTextData()
    
    // MARK: - Private properties -
    
    private let socket = WebSocket(url: URL(string: "wss://api.bitfinex.com/ws/")!)
    
    private lazy var textData: Observable<Data> = {
        return self.socket
        .rx
        .text
        .compactMap { $0.data(using: .utf8) }
    }()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle -
    
    init() {
        subscribeToEventsWhenConnected()
    }
    
    // MARK: - Public functions -
    
    func connect() {
        socket.connect()
    }
    
    // MARK: - Private functions -
    
    private func decodedTextData<T: Decodable>() -> Observable<T> {
        return textData.compactMap { $0.decoded() }
    }
    
    private func subscribeToEventsWhenConnected() {
        isConnected
            .filter { $0 == true }
            .subscribe(onNext: { [unowned socket] _ in
                if let tickerRequest = TickerRequest(event: "subscribe", channel: "ticker", pair: "BTCUSD").utf8String {
                    socket.write(string: tickerRequest)
                }
                
                if let orderBookRequest = OrderBookRequest(event: "subscribe", channel: "book", pair: "BTCUSD", prec: "P0", freq: "F1").utf8String {
                    socket.write(string: orderBookRequest)
                }
            })
            .disposed(by: disposeBag)
    }
    
}
