//
//  FirebaseStateProvider.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 26/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable multiple_closures_with_trailing_closure
// swiftlint:disable multiline_arguments

import RxSwift
import Firebase

typealias FirebaseCompletion = (Error?) -> Void
typealias FirebaseCardCompletion = (CardProtocol?, Error?) -> Void

protocol FirebaseStateProviderProtocol {
    func observe(completion: @escaping ((GameStateProtocol) -> Void))
    func setTurn(_ turn: String, completion: @escaping FirebaseCompletion)
    func setChallenge(_ challenge: Challenge?, completion: @escaping FirebaseCompletion)
    func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int, completion: @escaping FirebaseCompletion)
    func deckRemoveFirst(completion: @escaping FirebaseCardCompletion)
}

class FirebaseStateProvider: FirebaseStateProviderProtocol {
    
    private let gameId: String
    private let mapper: FirebaseMapperProtocol
    private let rootRef = Database.database().reference()
    
    init(gameId: String, mapper: FirebaseMapperProtocol) {
        self.gameId = gameId
        self.mapper = mapper
    }
    
    func observe(completion: @escaping ((GameStateProtocol) -> Void)) {
        rootRef.child("games").child(gameId).observe(.value, with: { snapshot in
            let state = self.mapper.decodeState(from: snapshot)
            completion(state)
            
        }) { error in
            fatalError(error.localizedDescription)
        }
    }
    
    func setTurn(_ turn: String, completion: @escaping FirebaseCompletion) {
        rootRef.child("games/\(gameId)/turn").setValue(turn) { error, _ in
            completion(error)
        }
    }
    
    func setChallenge(_ challenge: Challenge?, completion: @escaping FirebaseCompletion) {
        let value = mapper.encodeChallenge(challenge)
        rootRef.child("games/\(gameId)/challenge").setValue(value) { error, _ in
            completion(error)
        }
    }
    
    func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int, completion: @escaping FirebaseCompletion) {
        rootRef.child("games/\(gameId)/players/\(playerId)/bangsPlayed").setValue(bangsPlayed) { error, _ in
            completion(error)
        }
    }
    
    func deckRemoveFirst(completion: @escaping FirebaseCardCompletion) {
        fatalError()
    }
}
