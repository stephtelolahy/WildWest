//
//  FirebaseProvider.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift
import Firebase

protocol FirebaseProviderProtocol {
    
    // Create game
    // return gameId
    func createGame(_ state: GameStateProtocol) -> String
    
    // Observe game with given id
    func observeGame(_ id: String, completion: @escaping ((BehaviorSubject<GameStateProtocol>) -> Void))
}

class FirebaseProvider: FirebaseProviderProtocol {
    
    func createGame(_ state: GameStateProtocol) -> String {
        let rootRef = Database.database().reference()
        let gamesRef = rootRef.child("games")
        
        guard let key = gamesRef.childByAutoId().key else {
            fatalError("Unable to create games child")
        }
        
        let gameItemRef = gamesRef.child(key)
        
        let dto = DtoEncoder().map(state: state)
        guard let value = try? DictionaryEncoder().encode(dto) else {
            fatalError("Unable to create value")
        }
        
        gameItemRef.setValue(value)
        
        return key
    }
    
    func observeGame(_ id: String, completion: @escaping ((BehaviorSubject<GameStateProtocol>) -> Void)) {
        let rootRef = Database.database().reference()
        rootRef.child("games").child(id).observe(.value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            print(value)
            
        }) { error in
            fatalError(error.localizedDescription)
        }
    }
}
