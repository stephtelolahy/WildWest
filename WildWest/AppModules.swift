//
//  AppModules.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import Firebase

extension MatchingManager {
    static let shared = DependecyResolver().createMatchingManager()
}

class DependecyResolver {
    
    func createMatchingManager() -> MatchingManagerProtocol {
        let database = MatchingDatabase(rootRef: Database.database().reference(),
                                        mapper: firebaseMapper)
        return MatchingManager(database: database)
    }
    
    private lazy var firebaseMapper: FirebaseMapperProtocol = {
        FirebaseMapper(dtoEncoder: DtoEncoder(keyGenerator: FirebaseKeyGenerator()),
                       dtoDecoder: DtoDecoder(allCards: gameResources.allCards),
                       dictionaryEncoder: DictionaryEncoder(),
                       dictionaryDecoder: DictionaryDecoder())
    }()
    
    private lazy var gameResources: GameResources = {
        let jsonReader = JsonReader(bundle: Bundle.main)
        let resources = GameResources(jsonReader: jsonReader)
        return resources
    }()
}
