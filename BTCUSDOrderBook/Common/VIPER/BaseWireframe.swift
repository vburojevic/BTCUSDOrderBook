//
//  BaseWireframe.swift
//  Innosure
//
//  Created by Vedran Burojevic on 08/03/2019.
//  Copyright © 2019 CodeControl GmbH. All rights reserved.
//

import UIKit
import RxAlertController
import RxSwift
import RxCocoa

protocol WireframeInterface: class {
    func dismiss()
    func dismiss(completion: (() -> Void)?)
    func pop()
    func close()
    
    func rxShowAlert(withTitle title: String?, message: String?, buttonTitles: [String], preferredStyle: UIAlertController.Style) -> Single<Int>
}

class BaseWireframe: WireframeInterface {
    
    enum NavigationType {
        case present
        case push
    }
    
    fileprivate unowned var _viewController: UIViewController
    fileprivate var _temporaryStoredViewController: UIViewController? // To retain view controller reference upon first access
    
    init(viewController: UIViewController) {
        _temporaryStoredViewController = viewController
        _viewController = viewController
    }
    
}

extension BaseWireframe {
    
    var viewController: UIViewController {
        defer { _temporaryStoredViewController = nil }
        return _viewController
    }
    
    var navigationController: UINavigationController? {
        return viewController.navigationController
    }
    
}

extension UIViewController {
    
    func presentWireframe(_ wireframe: BaseWireframe, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
    
}

extension UINavigationController {
    
    func pushWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.pushViewController(wireframe.viewController, animated: animated)
    }
    
    func setRootWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.setViewControllers([wireframe.viewController], animated: animated)
    }
    
}

extension WireframeInterface where Self: BaseWireframe {
    
    func dismiss() {
        viewController.dismiss(animated: true)
    }
    
    func dismiss(completion: (() -> Void)?) {
        viewController.dismiss(animated: true, completion: completion)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func close() {
        guard let navigationController = navigationController else {
            dismiss()
            return
        }
        
        if navigationController.viewControllers.count > 1 {
            pop()
        } else {
            dismiss()
        }
    }
    
}

extension WireframeInterface where Self: BaseWireframe {
    
    func rxShowAlert(withTitle title: String?, message: String? = nil, buttonTitles: [String], preferredStyle: UIAlertController.Style = .alert) -> Single<Int> {
        return UIAlertController.rx.show(in: viewController, title: title, message: message, buttonTitles: buttonTitles, preferredStyle: preferredStyle)
    }
    
}
