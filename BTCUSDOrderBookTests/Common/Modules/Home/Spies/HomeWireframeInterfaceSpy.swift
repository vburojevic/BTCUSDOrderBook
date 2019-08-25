//
//  HomeWireframeInterfaceSpy.swift
//  BTCUSDOrderBookTests
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

@testable import BTCUSDOrderBook
import UIKit
import RxSwift

final class HomeWireframeInterfaceSpy: HomeWireframeInterface {
    
    var invokedNavigate = false
    var invokedNavigateCount = 0
    var invokedNavigateParameters: (option: HomeNavigationOption, Void)?
    var invokedNavigateParametersList = [(option: HomeNavigationOption, Void)]()
    
    func navigate(to option: HomeNavigationOption) {
        invokedNavigate = true
        invokedNavigateCount += 1
        invokedNavigateParameters = (option, ())
        invokedNavigateParametersList.append((option, ()))
    }
    
    var invokedDismiss = false
    var invokedDismissCount = 0
    
    func dismiss() {
        invokedDismiss = true
        invokedDismissCount += 1
    }
    
    var invokedDismissCompletion = false
    var invokedDismissCompletionCount = 0
    var shouldInvokeDismissCompletionCompletion = false
    
    func dismiss(completion: (() -> Void)?) {
        invokedDismissCompletion = true
        invokedDismissCompletionCount += 1
        if shouldInvokeDismissCompletionCompletion {
            completion?()
        }
    }
    
    var invokedPop = false
    var invokedPopCount = 0
    
    func pop() {
        invokedPop = true
        invokedPopCount += 1
    }
    
    var invokedClose = false
    var invokedCloseCount = 0
    
    func close() {
        invokedClose = true
        invokedCloseCount += 1
    }
    
    var invokedRxShowAlert = false
    var invokedRxShowAlertCount = 0
    var invokedRxShowAlertParameters: (title: String?, message: String?, buttonTitles: [String], preferredStyle: UIAlertController.Style)?
    var invokedRxShowAlertParametersList = [(title: String?, message: String?, buttonTitles: [String], preferredStyle: UIAlertController.Style)]()
    var stubbedRxShowAlertResult: Single<Int>!
    
    func rxShowAlert(withTitle title: String?, message: String?, buttonTitles: [String], preferredStyle: UIAlertController.Style) -> Single<Int> {
        invokedRxShowAlert = true
        invokedRxShowAlertCount += 1
        invokedRxShowAlertParameters = (title, message, buttonTitles, preferredStyle)
        invokedRxShowAlertParametersList.append((title, message, buttonTitles, preferredStyle))
        return stubbedRxShowAlertResult
    }
    
}
