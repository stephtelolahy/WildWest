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
        let environment = gameBuilder.createLocalGameEnvironment(state: state,
                                                                 eventMatcher: Resolver.resolve(),
                                                                 playerId: playerId)
        gameViewController.environment = environment
        
        let router = Router(viewController: gameViewController, dependencies: Resolver.resolve())
        gameViewController.router = router
        gameViewController.analyticsManager = Resolver.optional()
        gameViewController.animationMatcher = Resolver.optional()
        gameViewController.mediaMatcher = Resolver.optional()
        gameViewController.soundPlayer = Resolver.optional()
        gameViewController.inputHandler = InputHandler(selector: MoveSelector(), router: router)
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
    
    func resolveGameMoveSelectorWidget(_ title: String, children: [MoveNode], cancelable: Bool, completion: @escaping (MoveNode) -> Void) -> UIViewController {
        GameMoveSelectorWidget(title, children: children, cancelable: cancelable, completion: completion)
    }
}

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        
        register { DIContainer() as RouterDepenenciesProtocol }.scope(application)
        
        register { AnalyticsManager() }.scope(application)
        
        register { UserPreferences() as UserPreferencesProtocol }.scope(application)
        
        register { SoundPlayer(preferences: resolve()) as SoundPlayerProtocol }.scope(application)
        
        register { JsonReader(bundle: Bundle.resourcesBundle) as JsonReader }.scope(application)
        register { ResourcesLoader(jsonReader: resolve()) as ResourcesLoaderProtocol }.scope(application)
        
        register { FirebaseKeyGenerator() as KeyGeneratorProtocol }
        register { DictionaryEncoder() }
        
        register { AnimationEventMatcher(preferences: resolve()) as AnimationEventMatcherProtocol }.scope(application)
        
        register { createMediaMatcher() as MediaEventMatcherProtocol }.scope(application)
        
//        register { DtoEncoder(allCards: Resolver.resolve(ResourcesLoaderProtocol.self).allCards,
//                              keyGenerator: resolve())
//        }
//        register { FirebaseMapper(dtoEncoder: resolve(), dictionaryEncoder: resolve()) as FirebaseMapperProtocol }
//            .scope(application)
//
//        register { MatchingDatabase(rootRef: Database.database().reference(),
//                                    mapper: resolve()) as MatchingDatabaseProtocol
//        }.scope(application)
        
        register { GameBuilder(preferences: resolve(),
                               resourcesLoader: resolve()) as GameBuilderProtocol
        }
        
        register { AccountProvider() as AccountProviderProtocol }
        
//        register { MatchingManager(accountProvider: resolve(),
//                                   database: resolve(),
//                                   gameBuilder: resolve()) as MatchingManagerProtocol
//        }.scope(application)
    }
    
    private static func createMediaMatcher() -> MediaEventMatcherProtocol {
        let jsonReader = JsonReader(bundle: Bundle.main)
        let mediaArray: [EventMedia] = jsonReader.load("media")
        return MediaEventMatcher(mediaArray: mediaArray)
    }
}
