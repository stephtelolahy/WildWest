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
    private let stateAdapter: FirebaseStateAdapterProtocol
    
    init(stateSubject: BehaviorSubject<GameStateProtocol>,
         stateAdapter: FirebaseStateAdapterProtocol) {
        self.stateSubject = stateSubject
        self.stateAdapter = stateAdapter
        observeStateChanges()
    }
    
    func setTurn(_ turn: String) -> Completable {
        Completable.firebaseTransaction { completion in
            self.stateAdapter.setTurn(turn, completion)
        }
    }
    
    func setChallenge(_ challenge: Challenge?) -> Completable {
        Completable.firebaseTransaction { completion in
            self.stateAdapter.setChallenge(challenge, completion)
        }
    }
    
    func setOutcome(_ outcome: GameOutcome) -> Completable {
        Completable.firebaseTransaction { completion in
            self.stateAdapter.setOutcome(outcome, completion)
        }
    }
    
    func deckRemoveFirst() -> Single<CardProtocol> {
        let verifyDeckSize = Completable.firebaseTransaction { completion in
            self.stateAdapter.resetDeck(when: 2, completion)
        }
        
        let deckRemoveFirst = Completable.firebaseCardTransaction { completion in
            self.stateAdapter.deckRemoveFirst(completion)
        }
        
        return verifyDeckSize.andThen(deckRemoveFirst)
    }
    
    func addDiscard(_ card: CardProtocol) -> Completable {
        Completable.firebaseTransaction { completion in
            self.stateAdapter.addDiscard(card, completion)
        }
    }
    
    func addGeneralStore(_ card: CardProtocol) -> Completable {
        Completable.firebaseTransaction { completion in
            self.stateAdapter.addGeneralStore(card, completion)
        }
    }
    
    func removeGeneralStore(_ cardId: String) -> Single<CardProtocol> {
        Completable.firebaseCardTransaction { completion in
            self.stateAdapter.removeGeneralStore(cardId, completion)
        }
    }
    
    func playerSetHealth(_ playerId: String, _ health: Int) -> Completable {
        Completable.firebaseTransaction { completion in
            self.stateAdapter.playerSetHealth(playerId, health, completion)
        }
    }
    
    func playerAddHand(_ playerId: String, _ card: CardProtocol) -> Completable {
        Completable.firebaseTransaction { completion in
            self.stateAdapter.playerAddHand(playerId, card, completion)
        }
    }
    
    func playerRemoveHand(_ playerId: String, _ cardId: String) -> Single<CardProtocol> {
        Completable.firebaseCardTransaction { completion in
            self.stateAdapter.playerRemoveHand(playerId, cardId, completion)
        }
    }
    
    func playerAddInPlay(_ playerId: String, _ card: CardProtocol) -> Completable {
        Completable.firebaseTransaction { completion in
            self.stateAdapter.playerAddInPlay(playerId, card, completion)
        }
    }
    
    func playerRemoveInPlay(_ playerId: String, _ cardId: String) -> Single<CardProtocol> {
        Completable.firebaseCardTransaction { completion in
            self.stateAdapter.playerRemoveInPlay(playerId, cardId, completion)
        }
    }
    
    func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int) -> Completable {
        Completable.firebaseTransaction { completion in
            self.stateAdapter.playerSetBangsPlayed(playerId, bangsPlayed, completion)
        }
    }
    
    func playerSetDamageEvent(_ playerId: String, _ event: DamageEvent) -> Completable {
        Completable.firebaseTransaction { completion in
            self.stateAdapter.playerSetDamageEvent(playerId, event, completion)
        }
    }
}

private extension RemoteDatabase {
    
    func observeStateChanges() {
        stateAdapter.observeState { [weak self] result in
            switch result {
            case let .success(state):
                self?.stateSubject.onNext(state)
                
            case let .error(error):
                self?.stateSubject.onError(error)
            }
        }
    }
}
