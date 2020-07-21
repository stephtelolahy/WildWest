//
//  FirebaseAdapter.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift
import Firebase

protocol FirebaseAdapterProtocol {
    func createGame(id: String, state: GameStateProtocol) -> Completable
    func getGame(_ id: String) -> Single<GameStateProtocol>
}

class FirebaseAdapter: FirebaseAdapterProtocol {
    
    private let mapper: FirebaseMapperProtocol
    private let rootRef = Database.database().reference()
    
    init(mapper: FirebaseMapperProtocol) {
        self.mapper = mapper
    }
    
    func createGame(id: String, state: GameStateProtocol) -> Completable {
        rootRef.child("games/\(id)/state").rxSetValue({ try self.mapper.encodeState(state) })
            .andThen(rootRef.child("games/\(id)/executedMove").rxSetValue({ nil }))
            .andThen(rootRef.child("games/\(id)/executedUpdate").rxSetValue({ nil }))
            .andThen(rootRef.child("games/\(id)/validMoves").rxSetValue({ nil }))
    }
    
    func getGame(_ id: String) -> Single<GameStateProtocol> {
        rootRef.child("games/\(id)/state").rxObserveSingleEvent { snapshot in
            try self.mapper.decodeState(from: snapshot)
        }
    }
}
