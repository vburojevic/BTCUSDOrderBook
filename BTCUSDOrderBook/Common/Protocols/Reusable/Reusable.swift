//
//  Reusable.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import UIKit

public protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}

extension UITableView {
    
    func register<T: UITableViewCell>(cellType: T.Type)
        where T: Reusable {
            self.register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T
        where T: Reusable {
            guard let cell = self.dequeueReusableCell(
                    withIdentifier: cellType.reuseIdentifier,
                    for: indexPath
            ) as? T else {
                fatalError("Failed to dequeue a cell with identifier \(cellType.reuseIdentifier)")
            }
            return cell
    }
    
}
