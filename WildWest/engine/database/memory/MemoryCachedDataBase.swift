//
//  MemoryCachedDataBase.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 27/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable force_cast

import RxSwift

class MemoryCachedDataBase: GameDatabaseProtocol {
    
    let stateSubject: BehaviorSubject<GameStateProtocol>
    
    private var mutableState: GameState
    
    init(state: GameStateProtocol) {
        stateSubject = BehaviorSubject(value: state)
        mutableState = state as! GameState
    }
    
    // MARK: - Flags
    
    func setTurn(_ turn: String) -> Completable {
        createTransaction {
            self.mutableState.turn = turn
        }
    }
    
    func setChallenge(_ challenge: Challenge?) -> Completable {
        createTransaction {
            self.mutableState.challenge = challenge
        }
    }
    
    func setOutcome(_ outcome: GameOutcome) -> Completable {
        createTransaction {
            self.mutableState.outcome = outcome
        }
    }
    
    // MARK: - Deck
    
    func deckRemoveFirst() -> Single<CardProtocol> {
        createCardTransaction {
            self.mutableState.verifyDeckSize()
            return self.mutableState.deck.removeFirst()
        }
    }
    
    func addDiscard(_ card: CardProtocol) -> Completable {
        createTransaction {
            self.mutableState.discardPile.insert(card, at: 0)
        }
    }
    
    func addGeneralStore(_ card: CardProtocol) -> Completable {
        createTransaction {
            self.mutableState.generalStore.append(card)
        }
    }
    
    func removeGeneralStore(_ cardId: String) -> Single<CardProtocol> {
        createCardTransaction {
            self.mutableState.generalStore.removeFirst(where: { $0.identifier == cardId })!
        }
    }
    
    func playerSetHealth(_ playerId: String, _ health: Int) -> Completable {
        createTransaction {
            self.mutablePlayer(playerId).health = health
        }
    }
    
    func playerAddHand(_ playerId: String, _ card: CardProtocol) -> Completable {
        createTransaction {
            self.mutablePlayer(playerId).hand.append(card)
        }
    }
    
    func playerRemoveHand(_ playerId: String, _ cardId: String) -> Single<CardProtocol> {
        createCardTransaction {
            self.mutablePlayer(playerId).hand.removeFirst(where: { $0.identifier == cardId })!
        }
    }
    
    func playerAddInPlay(_ playerId: String, _ card: CardProtocol) -> Completable {
        createTransaction {
            self.mutablePlayer(playerId).inPlay.append(card)
        }
    }
    
    func playerRemoveInPlay(_ playerId: String, _ cardId: String) -> Single<CardProtocol> {
        createCardTransaction {
            self.mutablePlayer(playerId).inPlay.removeFirst(where: { $0.identifier == cardId })!
        }
    }
    
    func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int) -> Completable {
        createTransaction {
            self.mutablePlayer(playerId).bangsPlayed = bangsPlayed
        }
    }
    
    func playerSetDamageEvent(_ playerId: String, _ event: DamageEvent) -> Completable {
        createTransaction {
            self.mutablePlayer(playerId).lastDamage = event
        }
    }
    
    // MARK: - Player
    
}

private extension MemoryCachedDataBase {
    
    func createTransaction(_ transaction: @escaping (() -> Void)) -> Completable {
        Completable.create { completable in
            transaction()
            self.emitState()
            completable(.completed)
            return Disposables.create()
        }
    }
    
    func createCardTransaction(_ transaction: @escaping (() -> CardProtocol)) -> Single<CardProtocol> {
        Single.create { single in
            let card = transaction()
            self.emitState()
            single(.success(card))
            return Disposables.create()
        }
    }
    
    func mutablePlayer(_ playerId: String) -> Player {
        mutableState.allPlayers.first(where: { $0.identifier == playerId }) as! Player
    }
    
    func emitState() {
        stateSubject.onNext(mutableState)
    }
}

private extension GameState {
    
    func verifyDeckSize() {
        let minimumDeckSize = 2
        if deck.count <= minimumDeckSize {
            let cards = discardPile
            deck.append(contentsOf: Array(cards[1..<cards.count]).shuffled())
            discardPile = Array(cards[0..<1])
        }
    }
}
