//
//  ObservableTypeExtensions.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
    
    func asDriverOnErrorComplete() -> Driver<Element> {
        return self.asDriver(onErrorDriveWith: Driver.empty())
    }
    
}
