//
//  RemoteDatabase.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

class RemoteDatabase: GameDatabaseProtocol {
    
    private let gameAdapter: FirebaseGameAdapterProtocol
    private let stateSubject: BehaviorSubject<GameStateProtocol>
    private let executedMoveSubject: PublishSubject<GameMove>
    private let executedUpdateSubject: PublishSubject<GameUpdate>
    private let validMovesSubject: PublishSubject<[GameMove]>
    
    init(gameAdapter: FirebaseGameAdapterProtocol,
         stateSubject: BehaviorSubject<GameStateProtocol>,
         executedMoveSubject: PublishSubject<GameMove>,
         executedUpdateSubject: PublishSubject<GameUpdate>,
         validMovesSubject: PublishSubject<[GameMove]>) {
        self.gameAdapter = gameAdapter
        self.stateSubject = stateSubject
        self.executedMoveSubject = executedMoveSubject
        self.executedUpdateSubject = executedUpdateSubject
        self.validMovesSubject = validMovesSubject
        
        observeStateChanges()
        observeExecutedMoveChanges()
        observeExecutedUpdateChanges()
        observeValidMovesChanges()
    }
    
    func setTurn(_ turn: String) -> Completable {
        Completable.firebaseTransaction { completion in
            self.gameAdapter.setTurn(turn, completion)
        }
    }
    
    func setChallenge(_ challenge: Challenge?) -> Completable {
        Completable.firebaseTransaction { completion in
            self.gameAdapter.setChallenge(challenge, completion)
        }
    }
    
    func setOutcome(_ outcome: GameOutcome) -> Completable {
        Completable.firebaseTransaction { completion in
            self.gameAdapter.setOutcome(outcome, completion)
        }
    }
    
    func deckRemoveFirst() -> Single<CardProtocol> {
        let verifyDeckSize = Completable.firebaseTransaction { completion in
            self.gameAdapter.resetDeck(when: 2, completion)
        }
        
        let deckRemoveFirst = Completable.firebaseCardTransaction { completion in
            self.gameAdapter.deckRemoveFirst(completion)
        }
        
        return verifyDeckSize.andThen(deckRemoveFirst)
    }
    
    func addDiscard(_ card: CardProtocol) -> Completable {
        Completable.firebaseTransaction { completion in
            self.gameAdapter.addDiscard(card, completion)
        }
    }
    
    func addGeneralStore(_ card: CardProtocol) -> Completable {
        Completable.firebaseTransaction { completion in
            self.gameAdapter.addGeneralStore(card, completion)
        }
    }
    
    func removeGeneralStore(_ cardId: String) -> Single<CardProtocol> {
        Completable.firebaseCardTransaction { completion in
            self.gameAdapter.removeGeneralStore(cardId, completion)
        }
    }
    
    func playerSetHealth(_ playerId: String, _ health: Int) -> Completable {
        Completable.firebaseTransaction { completion in
            self.gameAdapter.playerSetHealth(playerId, health, completion)
        }
    }
    
    func playerAddHand(_ playerId: String, _ card: CardProtocol) -> Completable {
        Completable.firebaseTransaction { completion in
            self.gameAdapter.playerAddHand(playerId, card, completion)
        }
    }
    
    func playerRemoveHand(_ playerId: String, _ cardId: String) -> Single<CardProtocol> {
        Completable.firebaseCardTransaction { completion in
            self.gameAdapter.playerRemoveHand(playerId, cardId, completion)
        }
    }
    
    func playerAddInPlay(_ playerId: String, _ card: CardProtocol) -> Completable {
        Completable.firebaseTransaction { completion in
            self.gameAdapter.playerAddInPlay(playerId, card, completion)
        }
    }
    
    func playerRemoveInPlay(_ playerId: String, _ cardId: String) -> Single<CardProtocol> {
        Completable.firebaseCardTransaction { completion in
            self.gameAdapter.playerRemoveInPlay(playerId, cardId, completion)
        }
    }
    
    func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int) -> Completable {
        Completable.firebaseTransaction { completion in
            self.gameAdapter.playerSetBangsPlayed(playerId, bangsPlayed, completion)
        }
    }
    
    func playerSetDamageEvent(_ playerId: String, _ event: DamageEvent) -> Completable {
        Completable.firebaseTransaction { completion in
            self.gameAdapter.playerSetDamageEvent(playerId, event, completion)
        }
    }
    
    // Events
    func setExecutedUpdate(_ update: GameUpdate) {
        gameAdapter.setExecutedUpdate(update) { _ in }
    }
    
    func setExecutedMove(_ move: GameMove) {
        gameAdapter.setExecutedMove(move) { _ in }
    }
    
    func setValidMoves(_ moves: [GameMove]) {
        gameAdapter.setValidMoves(moves) { _ in }
    }
}

private extension RemoteDatabase {
    
    func observeStateChanges() {
        gameAdapter.observeState { [weak self] result in
            switch result {
            case let .success(state):
                self?.stateSubject.onNext(state)
                
            case let .error(error):
                self?.stateSubject.onError(error)
            }
        }
    }
    
    func observeExecutedMoveChanges() {
        gameAdapter.observeExecutedMove { [weak self] result in
            switch result {
            case let .success(move):
                self?.executedMoveSubject.onNext(move)
                
            case let .error(error):
                self?.executedMoveSubject.onError(error)
            }
        }
    }
    
    func observeExecutedUpdateChanges() {
        gameAdapter.observeExecutedUpdate { [weak self] result in
            switch result {
            case let .success(update):
                self?.executedUpdateSubject.onNext(update)
                
            case let .error(error):
                self?.executedUpdateSubject.onError(error)
            }
        }
    }
    
    func observeValidMovesChanges() {
        gameAdapter.observeValidMoves { [weak self] result in
            switch result {
            case let .success(moves):
                self?.validMovesSubject.onNext(moves)
                
            case let .error(error):
                self?.validMovesSubject.onError(error)
            }
        }
    }
}
