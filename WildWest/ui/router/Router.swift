//
//  Router.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 01/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import UIKit
import SafariServices
import WildWestEngine

// Present screens or widgets
protocol RouterProtocol {
    func toMenu()
    func toFigureSelector(completion: @escaping (String?) -> Void)
    func toRoleSelector(_ completion: @escaping (Role?) -> Void)
    func toContactUs()
    func toRules()
    func toLocalGame()
    func toOnlineGame()
}

protocol RouterDepenenciesProtocol {
    func resolveFigureSelector(_ completion: @escaping (String?) -> Void) -> UIViewController
    func resolveRoleSelector(_ completion: @escaping (Role?) -> Void) -> UIViewController
    func resolveLocalGameViewController() -> UIViewController
    func resolveMenuViewController() -> UIViewController
}

class Router: RouterProtocol {
    
    private weak var viewController: UIViewController?
    private let dependencies: RouterDepenenciesProtocol
    
    init(viewController: UIViewController, dependencies: RouterDepenenciesProtocol) {
        self.viewController = viewController
        self.dependencies = dependencies
    }
    
    func toMenu() {
        let navController: UINavigationController?
        if viewController is UINavigationController {
            navController = viewController as? UINavigationController
        } else {
            navController = viewController?.navigationController
        }
        
        navController?.fade(to: dependencies.resolveMenuViewController())
    }
    
    func toFigureSelector(completion: @escaping (String?) -> Void) {
        viewController?.present(dependencies.resolveFigureSelector(completion), animated: true)
    }
    
    func toRoleSelector(_ completion: @escaping (Role?) -> Void) {
        viewController?.present(dependencies.resolveRoleSelector(completion), animated: true)
    }
    
    func toLocalGame() {
        viewController?.navigationController?.fade(to: dependencies.resolveLocalGameViewController())
    }
    
    func toOnlineGame() {
    }
    
    func toContactUs() {
        let email = "stephano.telolahy@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
            viewController?.openUrl(url)
        }
    }
    
    func toRules() {
        let rulesUrl = "http://www.dvgiochi.net/bang/bang_rules.pdf"
        if let url = URL(string: rulesUrl) {
            if #available(iOS 11.0, *) {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                let safariViewController = SFSafariViewController(url: url, configuration: config)
                viewController?.present(safariViewController, animated: true)
            } else {
                viewController?.openUrl(url)
            }
        }
    }
}

private extension UINavigationController {
    
    func fade(to viewController: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.type = .fade
        view.layer.add(transition, forKey: nil)
        setViewControllers([viewController], animated: false)
    }
}

private extension UIViewController {
    
    func openUrl(_ url: URL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
