//
//  RemoteDatabase.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable type_body_length

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
        Completable.create { completable in
            self.stateAdapter.setTurn(turn) { error in
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
            self.stateAdapter.setChallenge(challenge) { error in
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
        // TODO: verify deck size
        Single.create { single in
            self.stateAdapter.deckRemoveFirst { card, error in
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
        Completable.create { completable in
            self.stateAdapter.playerAddHand(playerId, card) { error in
                if let error = error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create()
        }
    }
    
    func playerRemoveHand(_ playerId: String, _ cardId: String) -> Single<CardProtocol> {
        Single.create { single in
            self.stateAdapter.playerRemoveHand(playerId, cardId) { card, error in
                if let error = error {
                    single(.error(error))
                } else {
                    single(.success(card!))
                }
            }
            return Disposables.create()
        }
    }
    
    func playerAddInPlay(_ playerId: String, _ card: CardProtocol) -> Completable {
        Completable.create { completable in
            self.stateAdapter.playerAddInPlay(playerId, card) { error in
                if let error = error {
                    completable(.error(error))
                } else {
                    completable(.completed)
                }
            }
            return Disposables.create()
        }
    }
    
    func playerRemoveInPlay(_ playerId: String, _ cardId: String) -> Single<CardProtocol> {
        fatalError()
    }
    
    func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int) -> Completable {
        Completable.create { completable in
            self.stateAdapter.playerSetBangsPlayed(playerId, bangsPlayed) { error in
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
        stateAdapter.observe { [weak self] state in
            self?.stateSubject.onNext(state)
        }
    }
}
