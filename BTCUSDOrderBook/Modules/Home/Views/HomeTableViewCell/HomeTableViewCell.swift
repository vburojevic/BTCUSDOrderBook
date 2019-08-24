//
//  HomeTableViewCell.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 24/08/2019.
//  Copyright © 2019 Caffeinated Code. All rights reserved.
//

import UIKit

final class HomeTableViewCell: UITableViewCell, Reusable {
    
    // MARK: - Private properties -
    
    private let buyPriceLabel = HomeTableViewCell.createLabel()
    private let buyAmountLabel = HomeTableViewCell.createLabel()
    private let sellPriceLabel = HomeTableViewCell.createLabel()
    private let sellAmountLabel = HomeTableViewCell.createLabel()
    
    // MARK: - Lifecycle -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public functions -
    
    func configure(with item: HomeCellItem) {
        buyPriceLabel.text = item.buyPrice
        buyAmountLabel.text = item.buyAmount
        sellPriceLabel.text = item.sellPrice
        sellAmountLabel.text = item.sellAmount
    }
    
    // MARK: - Private functions -
    
    private func configureView() {
        // View
        selectionStyle = .none
        
        // Buy stack view
        let buyStackView = UIStackView(arrangedSubviews: [buyPriceLabel, buyAmountLabel])
        buyStackView.distribution = .fillEqually
        buyStackView.alignment = .leading
        
        // Sell stack view
        let sellStackView = UIStackView(arrangedSubviews: [sellPriceLabel, sellAmountLabel])
        sellStackView.distribution = .fillEqually
        sellStackView.alignment = .leading
        
        // Content stack view
        let contentStackView = UIStackView(arrangedSubviews: [buyStackView, sellStackView])
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.distribution = .fillEqually
        contentStackView.spacing = 16
        
        contentView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            contentStackView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 16),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            contentStackView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -16)
        ])
    }
    
    private static func createLabel() -> Label {
        let label = Label(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }
    
}
