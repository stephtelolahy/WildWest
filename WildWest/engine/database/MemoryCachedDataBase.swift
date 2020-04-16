//
//  MemoryCachedDataBase.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 27/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class MemoryCachedDataBase: GameDatabaseProtocol {
    
    private var mutableState: GameState
    
    init(state: GameStateProtocol) {
        guard let mutableState = state as? GameState else {
            fatalError("Cannot create mutable state")
        }
        
        self.mutableState = mutableState
    }
    
    var state: GameStateProtocol {
        mutableState
    }
    
    // Flags
    
    func setTurn(_ turn: String) {
        mutableState.turn = turn
    }
    
    func setChallenge(_ challenge: Challenge?) {
        mutableState.challenge = challenge
    }
    
    func setOutcome(_ outcome: GameOutcome) {
        mutableState.outcome = outcome
    }
    
    /// Deck
    
    func deckRemoveFirst() -> CardProtocol {
        mutableState.deck.removeFirst()
    }
    
    func addDiscard(_ card: CardProtocol) {
        mutableState.deck.append(card)
        mutableState.discardPile = [card]
    }
    
    func addGeneralStore(_ card: CardProtocol) {
        mutableState.generalStore.append(card)
    }
    
    func removeGeneralStore(_ cardId: String) -> CardProtocol? {
        mutableState.generalStore.removeFirst(where: { $0.identifier == cardId })
    }
    
    /// Player
    
    func playerSetHealth(_ playerId: String, _ health: Int) {
        mutablePlayer(playerId)?.health = health
    }
    
    func playerAddHand(_ playerId: String, _ card: CardProtocol) {
        mutablePlayer(playerId)?.hand.append(card)
    }
    
    func playerRemoveHand(_ playerId: String, _ cardId: String) -> CardProtocol? {
        mutablePlayer(playerId)?.hand.removeFirst(where: { $0.identifier == cardId })
    }
    
    func playerAddInPlay(_ playerId: String, _ card: CardProtocol) {
        mutablePlayer(playerId)?.inPlay.append(card)
    }
    
    func playerRemoveInPlay(_ playerId: String, _ cardId: String) -> CardProtocol? {
        mutablePlayer(playerId)?.inPlay.removeFirst(where: { $0.identifier == cardId })
    }
    
    func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int) {
        mutablePlayer(playerId)?.bangsPlayed = bangsPlayed
    }
    
    func playerSetDamageEvent(_ playerId: String, _ event: DamageEvent) {
        mutablePlayer(playerId)?.lastDamage = event
    }
}

private extension MemoryCachedDataBase {
    func mutablePlayer(_ playerId: String) -> Player? {
        mutableState.allPlayers.first(where: { $0.identifier == playerId }) as? Player
    }
}
