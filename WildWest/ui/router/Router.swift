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
    func toGameRoles(_ playersCount: Int)
    func toGameOver(_ winner: Role)
    func toGamePlayer(_ player: PlayerProtocol)
    func toWaitingRoom()
}

protocol RouterDepenenciesProtocol {
    func resolveFigureSelectorWidget(_ completion: @escaping (String?) -> Void) -> UIViewController
    func resolveRoleSelectorWidget(_ completion: @escaping (Role?) -> Void) -> UIViewController
    func resolveLocalGameViewController() -> UIViewController
    func resolveMenuViewController() -> UIViewController
    func resolveGameRolesWidget(_ playersCount: Int) -> UIViewController
    func resolveGameOverWidget(winner: Role, completion: @escaping () -> Void) -> UIViewController
    func resolveGamePlayerWidget(_ player: PlayerProtocol) -> UIViewController
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
        viewController?.present(dependencies.resolveFigureSelectorWidget(completion), animated: true)
    }
    
    func toRoleSelector(_ completion: @escaping (Role?) -> Void) {
        viewController?.present(dependencies.resolveRoleSelectorWidget(completion), animated: true)
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
    
    func toLocalGame() {
        viewController?.navigationController?.fade(to: dependencies.resolveLocalGameViewController())
    }
    
    func toGameRoles(_ playersCount: Int) {
        viewController?.present(dependencies.resolveGameRolesWidget(playersCount), animated: true)
    }
    
    func toGameOver(_ winner: Role) {
        let widget = dependencies.resolveGameOverWidget(winner: winner) { [weak self] in
            self?.toMenu()
        }
        viewController?.present(widget, animated: true)
    }
    
    func toGamePlayer(_ player: PlayerProtocol) {
        viewController?.present(dependencies.resolveGamePlayerWidget(player), animated: true)
    }
    
    func toWaitingRoom() {
        #warning("TODO: implement")
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
