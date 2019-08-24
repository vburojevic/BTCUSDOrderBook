//
//  AppDelegate.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Public properties -

    var window: UIWindow?
    
    // MARK: - Public functions -
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Dependencies
        initializeDependencies()
        
        // Window
        showAppWindow()
        
        SocketService.instance.connect()
        
        SocketService
            .instance
            .orderBookSubscription
            .subscribe(onNext: { orderBookSubscription in
                print("👌 \(orderBookSubscription)")
            })
        
        SocketService
            .instance
            .ticker
            .subscribe(onNext: { ticker in
                print("⏱️ \(ticker)")
            })
        
        SocketService
            .instance
            .orderBookSnapshot
            .subscribe(onNext: { orderBookSnapshot in
                print("📚 \(orderBookSnapshot)")
            })
        
        SocketService
            .instance
            .orderBookUpdate
            .subscribe(onNext: { orderBookUpdate in
                print("📝 \(orderBookUpdate)")
            })
        
        return true
    }
    
    // MARK: - Private functions -
    
    private func initializeDependencies() {
        let initializers: [Initializable] = [
            AppearanceInitializer()
        ]
        
        initializers.forEach { $0.initialize() }
    }

    private func showAppWindow() {
        guard window == nil else { return }
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }


}

