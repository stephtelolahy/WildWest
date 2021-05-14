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

extension DIContainer: RouterDependenciesProtocol {
    
    func provideMainViewController() -> UIViewController {
        let viewController = UIStoryboard.instantiate(MainViewController.self, in: "Main")
        viewController.userManager = Resolver.optional()
        viewController.gameManager = Resolver.optional()
        viewController.router = provideRouter(viewController)
        return viewController
    }
    
    func provideFigureSelectorWidget(_ completion: @escaping (String?) -> Void) -> UIViewController {
        FigureSelectorWidget(gameResources: Resolver.resolve(), completion: completion)
    }
    
    func provideRoleSelectorWidget(_ completion: @escaping (Role?) -> Void) -> UIViewController {
        RoleSelectorWidget(completion)
    }
    
    func provideMenuViewController() -> UIViewController {
        let viewController = UIStoryboard.instantiate(MenuViewController.self, in: "Main")
        viewController.router = provideRouter(viewController)
        viewController.preferences = Resolver.optional()
        viewController.soundPlayer = Resolver.optional()
        viewController.userManager = Resolver.optional()
        viewController.gameManager = Resolver.optional()
        viewController.signInWidget = SignInWidget(viewController: viewController, userManager: Resolver.resolve())
        return viewController
    }
    
    func provideGameViewController(_ environment: GameEnvironment) -> UIViewController {
        let viewController = UIStoryboard.instantiate(GameViewController.self, in: "Main")
        viewController.environment = environment
        viewController.router = provideRouter(viewController)
        viewController.userManager = Resolver.optional()
        viewController.analyticsManager = Resolver.optional()
        viewController.animationMatcher = Resolver.optional()
        viewController.mediaMatcher = Resolver.optional()
        viewController.soundPlayer = Resolver.optional()
        viewController.moveSelector = GameMoveSelectorWidget(selector: MoveSelector(), viewController: viewController)
        viewController.moveSegmenter = MoveSegmenter()
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
        viewController.router = provideRouter(viewController)
        viewController.userManager = Resolver.optional()
        viewController.gameManager = Resolver.optional()
        return viewController
    }
    
    private func provideRouter(_ viewController: UIViewController) -> RouterProtocol {
        Router(viewController: viewController, dependencies: Resolver.resolve())
    }
}

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        
        register { DIContainer() as RouterDependenciesProtocol }.scope(application)
        
        register { AnalyticsManager() }.scope(application)
        
        register { UserPreferences() as UserPreferencesProtocol }.scope(application)
        
        register { SoundPlayer(preferences: resolve()) as SoundPlayerProtocol }.scope(application)
        
        register { JsonReader(bundle: Bundle.resourcesBundle) as JsonReader }.scope(application)
        register { ResourcesLoader(jsonReader: resolve()) as ResourcesLoaderProtocol }.scope(application)
        
        register { DictionaryEncoder() }
        
        register { AnimationEventMatcher(preferences: resolve()) as AnimationEventMatcherProtocol }.scope(application)
        register { AnimationEventMatcher(preferences: resolve()) as DurationMatcherProtocol }.scope(application)
        
        register { provideMediaMatcher() as MediaEventMatcherProtocol }.scope(application)
        
        register { DtoEncoder(databaseRef: Database.database().reference(), allCards: provideDeckCards()) }
        
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
    
    private static func provideMediaMatcher() -> MediaEventMatcherProtocol {
        let jsonReader = JsonReader(bundle: Bundle.main)
        let mediaArray: [EventMedia] = jsonReader.load("media")
        return MediaEventMatcher(mediaArray: mediaArray)
    }
    
    private static func provideDeckCards() -> [CardProtocol] {
        let resourcesLoader: ResourcesLoaderProtocol = resolve()
        let cards = resourcesLoader.loadCards()
        let cardSet = resourcesLoader.loadDeck()
        let deck = GSetup().setupDeck(cardSet: cardSet, cards: cards)
        return deck
    }
}
