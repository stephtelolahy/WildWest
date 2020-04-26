//
//  RemoteDatabase.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

class RemoteDatabase: GameDatabaseProtocol {
    
    internal let stateSubject: BehaviorSubject<GameStateProtocol>
    private let firebaseProvider: FirebaseProviderProtocol
    private let gameId: String
    
    init(stateSubject: BehaviorSubject<GameStateProtocol>,
         firebaseProvider: FirebaseProviderProtocol,
         gameId: String) {
        self.stateSubject = stateSubject
        self.firebaseProvider = firebaseProvider
        self.gameId = gameId
        observeStateChanges()
    }
    
    func setTurn(_ turn: String) -> Completable {
        fatalError()
    }
    
    func setChallenge(_ challenge: Challenge?) -> Completable {
        fatalError()
    }
    
    func setOutcome(_ outcome: GameOutcome) -> Completable {
        fatalError()
    }
    
    func deckRemoveFirst() -> Single<CardProtocol> {
        fatalError()
    }
    
    func addDiscard(_ card: CardProtocol) -> Completable {
        fatalError()
    }
    
    func addGeneralStore(_ card: CardProtocol) -> Completable {
        fatalError()
    }
    
    func removeGeneralStore(_ cardId: String) -> Single<CardProtocol> {
        fatalError()
    }
    
    func playerSetHealth(_ playerId: String, _ health: Int) -> Completable {
        fatalError()
    }
    
    func playerAddHand(_ playerId: String, _ card: CardProtocol) -> Completable {
        fatalError()
    }
    
    func playerRemoveHand(_ playerId: String, _ cardId: String) -> Single<CardProtocol> {
        fatalError()
    }
    
    func playerAddInPlay(_ playerId: String, _ card: CardProtocol) -> Completable {
        fatalError()
    }
    
    func playerRemoveInPlay(_ playerId: String, _ cardId: String) -> Single<CardProtocol> {
        fatalError()
    }
    
    func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int) -> Completable {
        fatalError()
    }
    
    func playerSetDamageEvent(_ playerId: String, _ event: DamageEvent) -> Completable {
        fatalError()
    }
}

private extension RemoteDatabase {
    func observeStateChanges() {
        firebaseProvider.observeGame(gameId) { [weak self] state in
            self?.stateSubject.onNext(state)
        }
    }
}
