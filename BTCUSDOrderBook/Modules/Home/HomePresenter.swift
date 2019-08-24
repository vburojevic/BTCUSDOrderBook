//
//  HomePresenter.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright (c) 2019 Caffeinated Code. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class HomePresenter {

    // MARK: - Private properties -

    private unowned let view: HomeViewInterface
    private let wireframe: HomeWireframeInterface
    private let interactor: HomeInteractorInterface

    // MARK: - Lifecycle -

    init(wireframe: HomeWireframeInterface, view: HomeViewInterface, interactor: HomeInteractorInterface) {
        self.wireframe = wireframe
        self.view = view
        self.interactor = interactor
    }
    
}

// MARK: - Extensions -

extension HomePresenter: HomePresenterInterface {
}
