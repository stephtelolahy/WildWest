//
//  AppModules.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Firebase

class AppModules {
    
    static let shared = AppModules()
    
    lazy var userPreferences = UserPreferences()
    
    lazy var matchingManager: MatchingManagerProtocol = {
        MatchingManager(database: matchingDatabase)
    }()
    
    lazy var matchingDatabase: MatchingDatabaseProtocol = {
        MatchingDatabase(rootRef: Database.database().reference(),
                         mapper: firebaseMapper)
    }()
    
    lazy var firebaseMapper: FirebaseMapperProtocol = {
        let dtoEncoder = DtoEncoder(allCards: gameResources.allCards,
                                    keyGenerator: FirebaseKeyGenerator())
        return FirebaseMapper(dtoEncoder: dtoEncoder,
                              dictionaryEncoder: DictionaryEncoder())
    }()
    
    lazy var gameResources: GameResources = {
        GameResources(jsonReader: JsonReader(bundle: Bundle.main))
    }()
    
}
