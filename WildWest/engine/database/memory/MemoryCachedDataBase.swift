//
//  MemoryCachedDataBase.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 27/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable force_cast
// swiftlint: disable type_body_length

import RxSwift

class MemoryCachedDataBase: GameDatabaseProtocol {
    
    internal let stateSubject: BehaviorSubject<GameStateProtocol>
    private var mutableState: GameState
    
    init(mutableState: GameState, stateSubject: BehaviorSubject<GameStateProtocol>) {
        self.mutableState = mutableState
        self.stateSubject = stateSubject
    }
    
    // MARK: - Flags
    
    func setTurn(_ turn: String) -> Completable {
        Completable.transaction {
            self.mutableState.turn = turn
            self.emitState()
        }
    }
    
    func setChallenge(_ challenge: Challenge?) -> Completable {
        Completable.transaction {
            self.mutableState.challenge = challenge
            self.emitState()
        }
    }
    
    func setOutcome(_ outcome: GameOutcome) -> Completable {
        Completable.transaction {
            self.mutableState.outcome = outcome
            self.emitState()
        }
    }
    
    // MARK: - Deck
    
    func deckRemoveFirst() -> Single<CardProtocol> {
        Completable.cardTransaction {
            self.mutableState.verifyDeckSize()
            let card = self.mutableState.deck.removeFirst()
            self.emitState()
            return card
        }
    }
    
    func addDiscard(_ card: CardProtocol) -> Completable {
        Completable.transaction {
            self.mutableState.discardPile.insert(card, at: 0)
            self.emitState()
        }
    }
    
    func addGeneralStore(_ card: CardProtocol) -> Completable {
        Completable.transaction {
            self.mutableState.generalStore.append(card)
            self.emitState()
        }
    }
    
    func removeGeneralStore(_ cardId: String) -> Single<CardProtocol> {
        Completable.cardTransaction {
            let card = self.mutableState.generalStore.removeFirst(where: { $0.identifier == cardId })!
            self.emitState()
            return card
        }
    }
    
    func playerSetHealth(_ playerId: String, _ health: Int) -> Completable {
        Completable.transaction {
            self.mutablePlayer(playerId).health = health
            self.emitState()
        }
    }
    
    func playerAddHand(_ playerId: String, _ card: CardProtocol) -> Completable {
        Completable.transaction {
            self.mutablePlayer(playerId).hand.append(card)
            self.emitState()
        }
    }
    
    func playerRemoveHand(_ playerId: String, _ cardId: String) -> Single<CardProtocol> {
        Completable.cardTransaction {
            let card = self.mutablePlayer(playerId).hand.removeFirst(where: { $0.identifier == cardId })!
            self.emitState()
            return card
        }
    }
    
    func playerAddInPlay(_ playerId: String, _ card: CardProtocol) -> Completable {
        Completable.transaction {
            self.mutablePlayer(playerId).inPlay.append(card)
        }
    }
    
    func playerRemoveInPlay(_ playerId: String, _ cardId: String) -> Single<CardProtocol> {
        Completable.cardTransaction {
            let card = self.mutablePlayer(playerId).inPlay.removeFirst(where: { $0.identifier == cardId })!
            self.emitState()
            return card
        }
    }
    
    func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int) -> Completable {
        Completable.transaction {
            self.mutablePlayer(playerId).bangsPlayed = bangsPlayed
            self.emitState()
        }
    }
    
    func playerSetDamageEvent(_ playerId: String, _ event: DamageEvent) -> Completable {
        Completable.transaction {
            self.mutablePlayer(playerId).lastDamage = event
            self.emitState()
        }
    }
}

private extension MemoryCachedDataBase {
    
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
