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
}

extension DIContainer: RouterDepenenciesProtocol {
    
    func resolveFigureSelectorWidget(_ completion: @escaping (String?) -> Void) -> UIViewController {
        FigureSelectorWidget(gameResources: Resolver.resolve(), completion: completion)
    }
    
    func resolveRoleSelectorWidget(_ completion: @escaping (Role?) -> Void) -> UIViewController {
        RoleSelectorWidget(completion)
    }
    
    func resolveMenuViewController() -> UIViewController {
        let menuViewController = UIStoryboard.instantiate(MenuViewController.self, in: "Main")
        menuViewController.router = Router(viewController: menuViewController, dependencies: Resolver.resolve())
        menuViewController.preferences = Resolver.optional()
        menuViewController.soundPlayer = Resolver.optional()
        return menuViewController
    }
    
    func resolveLocalGameViewController() -> UIViewController {
        let gameViewController = UIStoryboard.instantiate(GameViewController.self, in: "Main")
        
        let gameBuilder: GameBuilderProtocol = Resolver.resolve()
        let preferences: UserPreferencesProtocol = Resolver.resolve()
        let state = gameBuilder.createGame(for: preferences.playersCount)
        let playerId = state.playOrder.first
        let environment = gameBuilder.createLocalGameEnvironment(state: state, playerId: playerId)
        gameViewController.environment = environment
        
        gameViewController.router = Router(viewController: gameViewController, dependencies: Resolver.resolve())
        gameViewController.analyticsManager = Resolver.optional()
        gameViewController.animationMatcher = Resolver.optional()
        gameViewController.mediaMatcher = Resolver.optional()
        gameViewController.soundPlayer = Resolver.optional()
        gameViewController.inputHandler = InputHandler(selector: MoveSelector(), viewController: gameViewController)
        gameViewController.moveSegmenter = MoveSegmenter()
        return gameViewController
    }
    
    func resolveGameOverWidget(winner: Role, completion: @escaping () -> Void) -> UIViewController {
        GameOverWidget(winner: winner, completion: completion)
    }
    
    func resolveGameRolesWidget(_ playersCount: Int) -> UIViewController {
        GameRolesWidget(playersCount: playersCount)
    }
    
    func resolveGamePlayerWidget(_ player: PlayerProtocol) -> UIViewController {
        GamePlayerWidget(player: player)
    }
}
