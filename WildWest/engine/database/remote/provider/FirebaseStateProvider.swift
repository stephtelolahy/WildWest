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

protocol FirebaseStateProviderProtocol {
    func observe(completion: @escaping ((GameStateProtocol) -> Void))
    func setTurn(_ turn: String) -> Completable
}

class FirebaseStateProvider: FirebaseStateProviderProtocol {
    
    private let gameId: String
    private let mapper: FirebaseMapperProtocol
    
    init(gameId: String, mapper: FirebaseMapperProtocol) {
        self.gameId = gameId
        self.mapper = mapper
    }
    
    func observe(completion: @escaping ((GameStateProtocol) -> Void)) {
        let rootRef = Database.database().reference()
        rootRef.child("games").child(gameId).observe(.value, with: { snapshot in
            let state = self.mapper.decodeState(from: snapshot)
            completion(state)
            
        }) { error in
            fatalError(error.localizedDescription)
        }
    }
    
    func setTurn(_ turn: String) -> Completable {
        fatalError()
    }
}
