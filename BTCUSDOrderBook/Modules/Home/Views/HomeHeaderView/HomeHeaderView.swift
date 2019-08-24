//
//  HomeHeaderView.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeHeaderView: UIView {
    
    // MARK: - Private properties -
    
    private let pairLabel: Label = {
        let label = Label(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let lastValueLabel: Label = {
        let label = Label(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let volumeLabel = Label(frame: .zero)
    private let dailyChangePercentageLabel = Label(frame: .zero)
    private let lowLabel: Label = Label(frame: .zero)
    private let highLabel: Label = Label(frame: .zero)
    
    // MARK: - Lifecycle -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public functions -
    
    func configure(with item: HomeHeaderViewItem) {
        pairLabel.text = item.pair
        lastValueLabel.text = item.lastValue
        volumeLabel.text = item.volume
        dailyChangePercentageLabel.text = item.dailyChangePercentage
        dailyChangePercentageLabel.textColor = item.dailyChangePercentageColor
        lowLabel.text = item.low
        highLabel.text = item.high
    }
    
    // MARK: - Private functions -
    
    private func configureView() {
        // View
        backgroundColor = .backgroundSecondary
        
        // Main stack view
        let headerStackView = UIStackView(frame: .zero)
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.axis = .horizontal
        headerStackView.distribution = .fillEqually
        headerStackView.alignment = .fill
        
        addSubview(headerStackView)
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            headerStackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            headerStackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16)
        ])
        
        // Left stack view
        let leftStackView = UIStackView(arrangedSubviews: [pairLabel, volumeLabel, lowLabel])
        leftStackView.axis = .vertical
        leftStackView.alignment = .center
        leftStackView.spacing = 8
        headerStackView.addArrangedSubview(leftStackView)
        
        // Right stack view
        let rightStackView = UIStackView(arrangedSubviews: [lastValueLabel, dailyChangePercentageLabel, highLabel])
        rightStackView.axis = .vertical
        rightStackView.alignment = .center
        rightStackView.spacing = 8
        headerStackView.addArrangedSubview(rightStackView)
        
        // Orders stack view
        let footerStackView = UIStackView(frame: .zero)
        footerStackView.translatesAutoresizingMaskIntoConstraints = false
        footerStackView.axis = .vertical
        footerStackView.spacing = 8
        
        addSubview(footerStackView)
        
        NSLayoutConstraint.activate([
            footerStackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 32),
            footerStackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            footerStackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            footerStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
        
        // Buy orders label
        let buyOrdersLabel = Label(frame: .zero)
        buyOrdersLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        buyOrdersLabel.textColor = .primary
        buyOrdersLabel.text = Strings.buyOrders.localized
        buyOrdersLabel.textAlignment = .center
        
        // Sell orders label
        let sellOrdersLabel = Label(frame: .zero)
        sellOrdersLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        sellOrdersLabel.textColor = .error
        sellOrdersLabel.text = Strings.sellOrders.localized
        sellOrdersLabel.textAlignment = .center
        
        // Orders stack view
        let ordersStackView = UIStackView(frame: .zero)
        ordersStackView.distribution = .fillEqually
        ordersStackView.addArrangedSubviews([buyOrdersLabel, sellOrdersLabel])
        footerStackView.addArrangedSubview(ordersStackView)
        
        // Price and amount stack view
        let priceAndAmountStackView = UIStackView(arrangedSubviews: [createPriceAndAmountLabelsStackView(), createPriceAndAmountLabelsStackView()])
        priceAndAmountStackView.distribution = .fillEqually
        priceAndAmountStackView.spacing = 16
        footerStackView.addArrangedSubview(priceAndAmountStackView)
    }
    
    private func createPriceAndAmountLabelsStackView() -> UIStackView {
        // Price label
        let priceLabel = Label(frame: .zero)
        priceLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        priceLabel.text = Strings.price.localized.uppercased()
        
        // Amount
        let amountLabel = Label(frame: .zero)
        amountLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        amountLabel.text = Strings.amount.localized.uppercased()
        
        // Stack view
        let stackView = UIStackView(arrangedSubviews: [priceLabel, amountLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        
        return stackView
    }
    
}

extension Reactive where Base: HomeHeaderView {
    
    var item: Binder<HomeHeaderViewItem> {
        return Binder(self.base) { view, item in
            view.configure(with: item)
        }
    }
    
}
