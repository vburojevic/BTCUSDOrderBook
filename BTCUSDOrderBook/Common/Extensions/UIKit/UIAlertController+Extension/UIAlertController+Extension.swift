//
//  UIAlertController+Extension.swift
//  BTCUSDOrderBook
//
//  Created by Vedran Burojevic on 16.02.2021..
//  Copyright © 2021 Caffeinated Code. All rights reserved.
//

import UIKit
import RxSwift

extension UIAlertController {

    func setActions<T>(_ actions: [AlertAction<T>]) -> Maybe<T> {
        return Maybe.create(subscribe: { [weak self] maybe -> Disposable in
            guard let self = self else { return Disposables.create() }
            actions
                .map { $0.asUIAlertAction(with: maybe) }
                .forEach(self.addAction)
            return Disposables.create()
        })
    }

    static func present<T>(
        on viewController: UIViewController?,
        title: String?,
        message: String?,
        actions: [AlertAction<T>],
        style: UIAlertController.Style,
        sender: UIBarButtonItem? = nil,
        sourceView: UIView? = nil
    ) -> Maybe<T> {

        return Maybe.create(subscribe: { [weak viewController] maybe -> Disposable in
            guard let viewController = viewController else { return Disposables.create() }

            let alert = UIAlertController(title: title, message: message, preferredStyle: style)

            if let sender = sender {
                alert.popoverPresentationController?.barButtonItem = sender
            } else if let source = sourceView {
                alert.popoverPresentationController?.sourceView = source
                alert.popoverPresentationController?.sourceRect = source.bounds
            }

            actions
                .map { $0.asUIAlertAction(with: maybe) }
                .forEach(alert.addAction)

            DispatchQueue.main.async {
                viewController.present(alert, animated: true, completion: nil)
            }

            return Disposables.create { [weak alert] in
                alert?.dismiss(animated: true, completion: nil)
            }
        })
    }

}
