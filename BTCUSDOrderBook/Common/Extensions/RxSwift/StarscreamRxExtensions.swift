//
//  StarscreamRxExtensions.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import Foundation
import Starscream
import RxSwift
import RxCocoa

class RxWebSocketDelegateProxy: DelegateProxy<WebSocket, NSObjectProtocol>, DelegateProxyType, WebSocketDelegate {
    
    private weak var forwardDelegate: WebSocketDelegate?

    fileprivate let subject = PublishSubject<WebSocketEvent>()
    
    required init(webSocket: WebSocket) {
        super.init(parentObject: webSocket, delegateProxy: RxWebSocketDelegateProxy.self)
    }
    
    static func currentDelegate(for object: WebSocket) -> NSObjectProtocol? {
        return object.delegate as? NSObjectProtocol
    }
    
    static func setCurrentDelegate(_ delegate: NSObjectProtocol?, to object: WebSocket) {
        object.delegate = delegate as? WebSocketDelegate
    }
    
    static func registerKnownImplementations() {
        self.register { RxWebSocketDelegateProxy(webSocket: $0) }
    }

    func didReceive(event: WebSocketEvent, client: WebSocket) {
        subject.on(.next(event))
        forwardDelegate?.didReceive(event: event, client: client)
    }
    
    deinit {
        subject.onCompleted()
    }
}

extension WebSocket: ReactiveCompatible {}
extension Reactive where Base: WebSocket {
    
    var response: Observable<WebSocketEvent> {
        return RxWebSocketDelegateProxy.proxy(for: base).subject
    }
    
    var text: Observable<String> {
        return self.response
            .compactMap { response -> String? in
                guard case let .text(message) = response else {
                    return nil
                }
                return message
            }
    }
    
    var connected: Observable<Bool> {
        return self.response
            .compactMap { response -> Bool? in
                if case .connected = response {
                    return true
                } else if case .disconnected = response {
                    return false
                } else {
                    return nil
                }
        }
    }
    
}
