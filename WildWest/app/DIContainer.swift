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
import Firebase

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
        menuViewController.userManager = Resolver.optional()
        menuViewController.signInWidget = SignInWidget(viewController: menuViewController, userManager: Resolver.resolve())
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
        
        gameViewController.router = Router(viewController: gameViewController, dependencies: Resolver.resolve())
        gameViewController.analyticsManager = Resolver.optional()
        gameViewController.animationMatcher = Resolver.optional()
        gameViewController.mediaMatcher = Resolver.optional()
        gameViewController.soundPlayer = Resolver.optional()
        gameViewController.moveSelector = GameMoveSelectorWidget(selector: MoveSelector(), viewController: gameViewController)
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
        
        register { DtoEncoder() }
        
        register { FirebaseMapper(dtoEncoder: resolve(),
                                  dictionaryEncoder: resolve()) as FirebaseMapperProtocol
        }.scope(application)

        register { UserDatabase(rootRef: Database.database().reference(),
                                mapper: resolve()) as UserDatabaseProtocol
        }.scope(application)
        
        register { GameBuilder(preferences: resolve(),
                               resourcesLoader: resolve()) as GameBuilderProtocol
        }.scope(application)
        
        register { AuthProvider() as AuthProviderProtocol }.scope(application)
        
        register { UserManager(authProvider: resolve(),
                               database: resolve()) as UserManagerProtocol
        }.scope(application)
    }
    
    private static func createMediaMatcher() -> MediaEventMatcherProtocol {
        let jsonReader = JsonReader(bundle: Bundle.main)
        let mediaArray: [EventMedia] = jsonReader.load("media")
        return MediaEventMatcher(mediaArray: mediaArray)
    }
}
