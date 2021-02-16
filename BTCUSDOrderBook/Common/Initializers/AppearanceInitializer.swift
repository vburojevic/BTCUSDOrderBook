//
//  AppearanceInitializer.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import UIKit

final class AppearanceInitializer: Initializable {
    
    func initialize() {
        // Navigation bar
        UINavigationBar.appearance().barTintColor = .primary
        UINavigationBar.appearance().tintColor = .textSecondary
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.textSecondary
        ]
    }
    
}
