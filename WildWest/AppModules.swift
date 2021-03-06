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
    
    // Resolve essential singletons
    public static func registerAllServices() {
        
        register { AnalyticsManager() }.scope(application)
        
        register { UserPreferences() as UserPreferencesProtocol }.scope(application)
        
        register { JsonReader(bundle: Bundle.main) as JsonReaderProtocol }
        register { GameResources(jsonReader: resolve()) as GameResourcesProtocol }.scope(application)
        
        register { FirebaseKeyGenerator() as KeyGeneratorProtocol }
        register { DictionaryEncoder() }
        register { DtoEncoder(allCards: Resolver.resolve(GameResourcesProtocol.self).allCards,
                              keyGenerator: resolve())
        }
        register { FirebaseMapper(dtoEncoder: resolve(), dictionaryEncoder: resolve()) as FirebaseMapperProtocol }
            .scope(application)
        
        register { MatchingDatabase(rootRef: Database.database().reference(),
                                    mapper: resolve()) as MatchingDatabaseProtocol
        }.scope(application)
        
        register { GameBuilder(preferences: resolve(),
                               gameResources: resolve(),
                               firebaseMapper: resolve()) as GameBuilderProtocol
        }
        
        register { AccountProvider() as AccountProviderProtocol }
        
        register { MatchingManager(accountProvider: resolve(),
                                   database: resolve(),
                                   gameBuilder: resolve()) as MatchingManagerProtocol
        }.scope(application)
    }
}
