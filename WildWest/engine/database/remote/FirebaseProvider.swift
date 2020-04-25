//
//  FirebaseProvider.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable multiple_closures_with_trailing_closure
// swiftlint:disable multiline_arguments

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
    
    private let dtoEncoder: DtoEncoder
    private let dtoDecoder: DtoDecoder
    private let dictionaryEncoder: DictionaryEncoder
    private let dictionaryDecoder: DictionaryDecoder
    
    init(dtoEncoder: DtoEncoder,
         dtoDecoder: DtoDecoder,
         dictionaryEncoder: DictionaryEncoder,
         dictionaryDecoder: DictionaryDecoder) {
        self.dtoEncoder = dtoEncoder
        self.dtoDecoder = dtoDecoder
        self.dictionaryEncoder = dictionaryEncoder
        self.dictionaryDecoder = dictionaryDecoder
        
    }
    
    func createGame(_ state: GameStateProtocol) -> String {
        let rootRef = Database.database().reference()
        let gamesRef = rootRef.child("games")
        
        guard let key = gamesRef.childByAutoId().key else {
            fatalError("Unable to create games child")
        }
        
        let gameItemRef = gamesRef.child(key)
        
        let dto = dtoEncoder.map(state: state)
        guard let value = try? dictionaryEncoder.encode(dto) else {
            fatalError("Unable to create value")
        }
        
        gameItemRef.setValue(value)
        
        return key
    }
    
    func observeGame(_ id: String, completion: @escaping ((BehaviorSubject<GameStateProtocol>) -> Void)) {
        let rootRef = Database.database().reference()
        rootRef.child("games").child(id).observe(.value, with: { snapshot in
            
            guard let value = snapshot.value as? [String: Any] else {
                fatalError("Unable to create dictionary")
            }
            
            guard let dto = try? self.dictionaryDecoder.decode(StateDto.self, from: value) else {
                fatalError("Unable to create dto")
            }

            print(dto)
            
        }) { error in
            fatalError(error.localizedDescription)
        }
    }
}
