//
//  DIContainer.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 01/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import UIKit
import WildWestEngine
import Resolver

// The central unit of all injections.
// Instantiates and supplies the dependencies of all object

final class DIContainer {
    static let shared = DIContainer()
}

extension DIContainer: RouterDepenenciesProtocol {
    
    func resolveFigureSelector(_ completion: @escaping (String?) -> Void) -> UIViewController {
        FigureSelectorWidget(gameResources: Resolver.resolve(), completion: completion)
    }
    
    func resolveRoleSelector(_ completion: @escaping (Role?) -> Void) -> UIViewController {
        RoleSelectorWidget(completion)
    }
}
