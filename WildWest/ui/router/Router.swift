//
//  Router.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 01/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import UIKit
import WildWestEngine

// Present screens or widgets
protocol RouterProtocol {
    func toFigureSelector(completion: @escaping (String?) -> Void)
    func toRoleSelector(_ completion: @escaping (Role?) -> Void)
}

protocol RouterDepenenciesProtocol {
    func resolveFigureSelector(_ completion: @escaping (String?) -> Void) -> UIViewController
    func resolveRoleSelector(_ completion: @escaping (Role?) -> Void) -> UIViewController
}

class Router: RouterProtocol {
    
    private unowned let viewController: UIViewController
    private let dependencies: RouterDepenenciesProtocol
    
    init(viewController: UIViewController, dependencies: RouterDepenenciesProtocol) {
        self.viewController = viewController
        self.dependencies = dependencies
    }
    
    func toFigureSelector(completion: @escaping (String?) -> Void) {
        viewController.present(dependencies.resolveFigureSelector(completion), animated: true)
    }
    
    func toRoleSelector(_ completion: @escaping (Role?) -> Void) {
        viewController.present(dependencies.resolveRoleSelector(completion), animated: true)
    }
}
