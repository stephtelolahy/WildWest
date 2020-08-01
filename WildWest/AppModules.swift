//
//  AppModules.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Firebase
import Resolver

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        
        register { AnalyticsManager() }.scope(application)
        
        register { UserPreferences() as UserPreferencesProtocol }.scope(application)
        
        register { JsonReader(bundle: Bundle.main) as JsonReaderProtocol }
        register { GameResources(jsonReader: resolve()) as GameResourcesProtocol }.scope(application)
    }
}

class AppModules {
    
    static let shared = AppModules()
    
    lazy var accountManager: AccountManagerProtocol = AccountManager()
    
    lazy var matchingManager: MatchingManagerProtocol = MatchingManager(accountManager: accountManager,
                                                                        database: matchingDatabase,
                                                                        gameBuilder: gameBuilder)
    
    lazy var gameBuilder: GameBuilderProtocol = GameBuilder(preferences: Resolver.resolve(),
                                                            matchingDatabase: matchingDatabase,
                                                            gameResources: gameResources,
                                                            firebaseMapper: firebaseMapper)
    
    lazy var matchingDatabase: MatchingDatabaseProtocol = MatchingDatabase(rootRef: Database.database().reference(),
                                                                           mapper: firebaseMapper)
    
    lazy var firebaseMapper: FirebaseMapperProtocol = {
        let dtoEncoder = DtoEncoder(allCards: gameResources.allCards,
                                    keyGenerator: FirebaseKeyGenerator())
        return FirebaseMapper(dtoEncoder: dtoEncoder,
                              dictionaryEncoder: DictionaryEncoder())
    }()
    
    lazy var gameResources: GameResourcesProtocol = Resolver.resolve()
}
