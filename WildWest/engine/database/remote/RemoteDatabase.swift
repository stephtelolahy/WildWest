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
    private let stateProvider: FirebaseStateProviderProtocol
    
    init(stateSubject: BehaviorSubject<GameStateProtocol>,
         stateProvider: FirebaseStateProviderProtocol) {
        self.stateSubject = stateSubject
        self.stateProvider = stateProvider
        observeStateChanges()
    }
    
    func setTurn(_ turn: String) -> Completable {
        Completable.create { completable in
            self.stateProvider.setTurn(turn) { error in
                if let error = error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create()
        }
    }
    
    func setChallenge(_ challenge: Challenge?) -> Completable {
        Completable.create { completable in
            self.stateProvider.setChallenge(challenge) { error in
                if let error = error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create()
        }
    }
    
    func setOutcome(_ outcome: GameOutcome) -> Completable {
        fatalError()
    }
    
    func deckRemoveFirst() -> Single<CardProtocol> {
        Single.create { single in
            self.stateProvider.deckRemoveFirst { card, error in
                if let error = error {
                    single(.error(error))
                } else {
                    single(.success(card!))
                }
            }
            return Disposables.create()
        }
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
        Completable.create { completable in
            self.stateProvider.playerSetBangsPlayed(playerId, bangsPlayed) { error in
                if let error = error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create()
        }
    }
    
    func playerSetDamageEvent(_ playerId: String, _ event: DamageEvent) -> Completable {
        fatalError()
    }
}

private extension RemoteDatabase {
    
    func observeStateChanges() {
        stateProvider.observe { [weak self] state in
            self?.stateSubject.onNext(state)
        }
    }
}
