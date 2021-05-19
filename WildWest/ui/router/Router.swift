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
    func toGame(_ environment: GameEnvironment)
    func toGameRoles(_ playersCount: Int)
    func toGameOver(_ winner: Role)
    func toGamePlayer(_ player: PlayerProtocol)
    func toWaitingRoom()
}

protocol RouterDependenciesProtocol {
    func provideMainViewController() -> UIViewController
    func provideFigureSelectorWidget(_ completion: @escaping (String?) -> Void) -> UIViewController
    func provideRoleSelectorWidget(_ completion: @escaping (Role?) -> Void) -> UIViewController
    func provideGameViewController(_ environment: GameEnvironment) -> UIViewController
    func provideMenuViewController() -> UIViewController
    func provideGameRolesWidget(_ playersCount: Int) -> UIViewController
    func provideGameOverWidget(winner: Role, completion: @escaping () -> Void) -> UIViewController
    func provideGamePlayerWidget(_ player: PlayerProtocol) -> UIViewController
    func provideWaitingRoomViewController() -> UIViewController
}

class Router: RouterProtocol {
    
    private weak var viewController: UIViewController?
    private let dependencies: RouterDependenciesProtocol
    
    init(viewController: UIViewController, dependencies: RouterDependenciesProtocol) {
        self.viewController = viewController
        self.dependencies = dependencies
    }
    
    func toMenu() {
        navController?.fade(to: dependencies.provideMenuViewController())
    }
    
    func toFigureSelector(completion: @escaping (String?) -> Void) {
        viewController?.present(dependencies.provideFigureSelectorWidget(completion), animated: true)
    }
    
    func toRoleSelector(_ completion: @escaping (Role?) -> Void) {
        viewController?.present(dependencies.provideRoleSelectorWidget(completion), animated: true)
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
    
    func toGame(_ environment: GameEnvironment) {
        navController?.fade(to: dependencies.provideGameViewController(environment))
    }
    
    func toGameRoles(_ playersCount: Int) {
        viewController?.present(dependencies.provideGameRolesWidget(playersCount), animated: true)
    }
    
    func toGameOver(_ winner: Role) {
        let widget = dependencies.provideGameOverWidget(winner: winner) { [weak self] in
            self?.toMenu()
        }
        viewController?.present(widget, animated: true)
    }
    
    func toGamePlayer(_ player: PlayerProtocol) {
        viewController?.present(dependencies.provideGamePlayerWidget(player), animated: true)
    }
    
    func toWaitingRoom() {
        navController?.fade(to: dependencies.provideWaitingRoomViewController())
    }
}

private extension Router {
    
    var navController: UINavigationController? {
        if let navC = viewController as? UINavigationController {
            return navC
        } else {
            return viewController?.navigationController
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
