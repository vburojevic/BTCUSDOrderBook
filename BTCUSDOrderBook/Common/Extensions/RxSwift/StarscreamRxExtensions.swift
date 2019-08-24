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

enum WebSocketEvent {
    case connected
    case disconnected(Error?)
    case message(String)
    case data(Data)
    case pong
}

class RxWebSocketDelegateProxy<Client: WebSocketClient>: DelegateProxy<Client, NSObjectProtocol>, DelegateProxyType, WebSocketDelegate, WebSocketPongDelegate {
    
    private weak var forwardDelegate: WebSocketDelegate?
    private weak var forwardPongDelegate: WebSocketPongDelegate?
    
    fileprivate let subject = PublishSubject<WebSocketEvent>()
    
    required init(websocket: Client) {
        super.init(parentObject: websocket, delegateProxy: RxWebSocketDelegateProxy.self)
    }
    
    static func currentDelegate(for object: Client) -> NSObjectProtocol? {
        return object.delegate as? NSObjectProtocol
    }
    
    static func setCurrentDelegate(_ delegate: NSObjectProtocol?, to object: Client) {
        object.delegate = delegate as? WebSocketDelegate
        object.pongDelegate = delegate as? WebSocketPongDelegate
    }
    
    static func registerKnownImplementations() {
        self.register { RxWebSocketDelegateProxy(websocket: $0) }
    }
    
    func websocketDidConnect(socket: WebSocketClient) {
        subject.onNext(WebSocketEvent.connected)
        forwardDelegate?.websocketDidConnect(socket: socket)
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        subject.onNext(WebSocketEvent.disconnected(error))
        forwardDelegate?.websocketDidDisconnect(socket: socket, error: error)
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        subject.onNext(WebSocketEvent.message(text))
        forwardDelegate?.websocketDidReceiveMessage(socket: socket, text: text)
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        subject.onNext(WebSocketEvent.data(data))
        forwardDelegate?.websocketDidReceiveData(socket: socket, data: data)
    }
    
    func websocketDidReceivePong(socket: WebSocketClient, data: Data?) {
        subject.onNext(WebSocketEvent.pong)
        forwardPongDelegate?.websocketDidReceivePong(socket: socket, data: data)
    }
    
    deinit {
        subject.onCompleted()
    }
}

extension Reactive where Base: WebSocketClient {
    
    var response: Observable<WebSocketEvent> {
        return RxWebSocketDelegateProxy.proxy(for: base).subject
    }
    
    var text: Observable<String> {
        return self.response
            .compactMap { response -> String? in
                guard case let .message(message) = response else { return nil }
                return message
            }
    }
    
    var connected: Observable<Bool> {
        return self.response
            .compactMap { response -> Bool in
                if case .connected = response {
                    return true
                } else if case .disconnected = response {
                    return false
                }
                
                return false
        }
    }
    
    func write(data: Data) -> Observable<Void> {
        return Observable.create { subject in
            self.base.write(data: data) {
                subject.onNext(())
                subject.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func write(ping: Data) -> Observable<Void> {
        return Observable.create { subject in
            self.base.write(ping: ping) {
                subject.onNext(())
                subject.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func write(string: String) -> Observable<Void> {
        return Observable.create { subject in
            self.base.write(string: string) {
                subject.onNext(())
                subject.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
}
