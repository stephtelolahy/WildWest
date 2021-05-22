//
//  DIContainer.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 01/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//
// swiftlint:disable function_body_length
// swiftlint:disable force_cast

import UIKit
import WildWestEngine
import Resolver
import Firebase

// The central unit of all injections.
// Instantiates and supplies the dependencies of all object

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        
        // MARK: - UI
        
        register { main as RouterDependenciesProtocol }.scope(application)
        
        register { _, args in
            Router(viewController: args as! UIViewController, dependencies: resolve()) as RouterProtocol
        }
        
        // MARK: - Data
        
        register { AnalyticsManager() }.scope(application)
        
        register { UserPreferences() as UserPreferencesProtocol }.scope(application)
        
        register { SoundPlayer(preferences: resolve()) as SoundPlayerProtocol }.scope(application)
        
        register { JsonReader(bundle: Bundle.resourcesBundle) as JsonReader }.scope(application)
        register { ResourcesLoader(jsonReader: resolve()) as ResourcesLoaderProtocol }.scope(application)
        
        register { DictionaryEncoder() }
        
        register { AnimationEventMatcher(preferences: resolve()) as AnimationEventMatcherProtocol }.scope(application)
        
        register { AnimationEventMatcher(preferences: resolve()) as DurationMatcherProtocol }.scope(application)
        
        register(MediaEventMatcherProtocol.self) {
            let jsonReader = JsonReader(bundle: Bundle.main)
            let mediaArray: [EventMedia] = jsonReader.load("media")
            return MediaEventMatcher(mediaArray: mediaArray)
        }
        
        register(DtoEncoder.self) {
            let resourcesLoader: ResourcesLoaderProtocol = resolve()
            let cards = resourcesLoader.loadCards()
            let cardSet = resourcesLoader.loadDeck()
            let deck = GSetup().setupDeck(cardSet: cardSet, cards: cards)
            return DtoEncoder(databaseRef: Database.database().reference(), allCards: deck)
        }
        
        register { FirebaseMapper(dtoEncoder: resolve(),
                                  dictionaryEncoder: resolve()) as FirebaseMapperProtocol
        }.scope(application)
        
        register { UserDatabase(rootRef: Database.database().reference(), mapper: resolve()) as UserDatabaseProtocol
        }.scope(application)
        
        register { GameBuilder(preferences: resolve(),
                               resourcesLoader: resolve(),
                               durationMatcher: resolve(),
                               database: resolve()) as GameBuilderProtocol
        }.scope(application)
        
        register { AuthProvider() as AuthProviderProtocol }.scope(application)
        
        register { UserManager(authProvider: resolve(),
                               database: resolve()) as UserManagerProtocol
        }.scope(application)
        
        register { GameManager(preferences: resolve(),
                               database: resolve(),
                               gameBuilder: resolve()) as GameManagerProtocol
        }.scope(application)
    }
}

extension Resolver: RouterDependenciesProtocol {
    
    func provideMainViewController() -> UIViewController {
        let viewController = UIStoryboard.instantiate(MainViewController.self, in: "Main")
        viewController.userManager = optional()
        viewController.gameManager = optional()
        viewController.router = optional(args: viewController)
        return viewController
    }
    
    func provideFigureSelectorWidget(_ completion: @escaping (String?) -> Void) -> UIViewController {
        FigureSelectorWidget(gameResources: resolve(), completion: completion)
    }
    
    func provideRoleSelectorWidget(_ completion: @escaping (Role?) -> Void) -> UIViewController {
        RoleSelectorWidget(completion)
    }
    
    func provideMenuViewController() -> UIViewController {
        let viewController = UIStoryboard.instantiate(MenuViewController.self, in: "Main")
        viewController.router = optional(args: viewController)
        viewController.preferences = optional()
        viewController.soundPlayer = optional()
        viewController.userManager = optional()
        viewController.gameManager = optional()
        viewController.signInWidget = SignInWidget(viewController: viewController, userManager: resolve())
        return viewController
    }
    
    func provideGameViewController(_ environment: GameEnvironment) -> UIViewController {
        let viewController = UIStoryboard.instantiate(GameViewController.self, in: "Main")
        viewController.environment = environment
        viewController.router = optional(args: viewController)
        viewController.userManager = optional()
        viewController.analyticsManager = optional()
        viewController.animationMatcher = optional()
        viewController.mediaMatcher = optional()
        viewController.soundPlayer = optional()
        viewController.moveSelector = GameMoveSelectorWidget(selector: MoveSelector(), viewController: viewController)
        viewController.moveSegmenter = MoveSegmenter()
        viewController.preferences = optional()
        return viewController
    }
    
    func provideGameOverWidget(winner: Role, completion: @escaping () -> Void) -> UIViewController {
        GameOverWidget(winner: winner, completion: completion)
    }
    
    func provideGameRolesWidget(_ playersCount: Int) -> UIViewController {
        GameRolesWidget(playersCount: playersCount)
    }
    
    func provideGamePlayerWidget(_ player: PlayerProtocol) -> UIViewController {
        GamePlayerWidget(player: player)
    }
    
    func provideWaitingRoomViewController() -> UIViewController {
        let viewController = UIStoryboard.instantiate(WaitingRoomViewController.self, in: "Main")
        viewController.router = optional(args: viewController)
        viewController.userManager = optional()
        viewController.gameManager = optional()
        return viewController
    }
}
