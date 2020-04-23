//
//  MemoryCachedDataBase.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 27/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

class MemoryCachedDataBase: GameDatabaseProtocol {
    
    let stateSubject: BehaviorSubject<GameStateProtocol>
    
    private var mutableState: GameState
    
    init(state: GameStateProtocol) {
        guard let gameState = state as? GameState else {
            fatalError("Illegal state")
        }
        
        mutableState = gameState
        stateSubject = BehaviorSubject(value: state)
    }
    
    // Flags
    
    func setTurn(_ turn: String) {
        mutableState.turn = turn
        emitState()
    }
    
    func setChallenge(_ challenge: Challenge?) {
        mutableState.challenge = challenge
        emitState()
    }
    
    func setOutcome(_ outcome: GameOutcome) {
        mutableState.outcome = outcome
        emitState()
    }
    
    /// Deck
    
    func deckRemoveFirst() -> CardProtocol {
        let minimumDeckSize = 2
        if mutableState.deck.count <= minimumDeckSize {
            let cards = mutableState.discardPile
            mutableState.deck.append(contentsOf: Array(cards[1..<cards.count]).shuffled())
            mutableState.discardPile = Array(cards[0..<1])
        }
        
        let card = mutableState.deck.removeFirst()
        emitState()
        return card
    }
    
    func addDiscard(_ card: CardProtocol) {
        mutableState.discardPile.insert(card, at: 0)
        emitState()
    }
    
    func addGeneralStore(_ card: CardProtocol) {
        mutableState.generalStore.append(card)
        emitState()
    }
    
    func removeGeneralStore(_ cardId: String) -> CardProtocol? {
        let card = mutableState.generalStore.removeFirst(where: { $0.identifier == cardId })
        emitState()
        return card
    }
    
    /// Player
    
    func playerSetHealth(_ playerId: String, _ health: Int) {
        mutablePlayer(playerId)?.health = health
        emitState()
    }
    
    func playerAddHand(_ playerId: String, _ card: CardProtocol) {
        mutablePlayer(playerId)?.hand.append(card)
        emitState()
    }
    
    func playerRemoveHand(_ playerId: String, _ cardId: String) -> CardProtocol? {
        let card = mutablePlayer(playerId)?.hand.removeFirst(where: { $0.identifier == cardId })
        emitState()
        return card
    }
    
    func playerAddInPlay(_ playerId: String, _ card: CardProtocol) {
        mutablePlayer(playerId)?.inPlay.append(card)
        emitState()
    }
    
    func playerRemoveInPlay(_ playerId: String, _ cardId: String) -> CardProtocol? {
        let card = mutablePlayer(playerId)?.inPlay.removeFirst(where: { $0.identifier == cardId })
        emitState()
        return card
    }
    
    func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int) {
        mutablePlayer(playerId)?.bangsPlayed = bangsPlayed
        emitState()
    }
    
    func playerSetDamageEvent(_ playerId: String, _ event: DamageEvent) {
        mutablePlayer(playerId)?.lastDamage = event
        emitState()
    }
}

private extension MemoryCachedDataBase {
    
    func mutablePlayer(_ playerId: String) -> Player? {
        mutableState.allPlayers.first(where: { $0.identifier == playerId }) as? Player
    }
    
    func emitState() {
        stateSubject.onNext(mutableState)
    }
}
