//
//  HomeViewController.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright (c) 2019 Caffeinated Code. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: HomePresenterInterface!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Private functions -
    
    private func configureView() {
        // View
        view.backgroundColor = .backgroundPrimary
    }
	
}

// MARK: - Extensions -

extension HomeViewController: HomeViewInterface {
}