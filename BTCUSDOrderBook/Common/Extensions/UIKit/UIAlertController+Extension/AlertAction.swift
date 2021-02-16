//
//  AlertAction.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 16.02.2021..
//  Copyright © 2021 Caffeinated Code. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class AlertAction<T> {

    // MARK: - Static properties -

    static var cancel: AlertAction<T> {
        return AlertAction<T>(title: Strings.cancel.localized, style: .cancel)
    }

    // MARK: - Public properties -

    let title: String
    let style: UIAlertAction.Style
    let value: T?
    let isEnabled = BehaviorRelay(value: true)

    // MARK: - Private properties -

    private let disposeBag = DisposeBag()

    // MARK: - Lifecycle -

    init(title: String, style: UIAlertAction.Style = .default, value: T? = nil) {
        self.title = title
        self.style = style
        self.value = value
    }

    // MARK: - Public functions -

    func asUIAlertAction(with maybe: @escaping ((MaybeEvent<T>) -> Void)) -> UIAlertAction {
        let action = UIAlertAction(title: title, style: style, handler: { _ in
            if let value = self.value {
                maybe(.success(value))
            } else {
                maybe(.completed)
            }
        })

        isEnabled
            .asDriver()
            .drive(action.rx.isEnabled)
            .disposed(by: disposeBag)

        return action
    }

}
