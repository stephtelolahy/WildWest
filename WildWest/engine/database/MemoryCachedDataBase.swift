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
    
    func setBangsPlayed(_ bangsPlayed: Int) {
        mutableState.bangsPlayed = bangsPlayed
    }
    
    func setBarrelsResolved(_ barrelsResolved: Int) {
        mutableState.barrelsResolved = barrelsResolved
    }
    
    func addExecutedMove(_ move: GameMove) {
        mutableState.executedMoves.append(move)
    }
    
    func setValidMoves(_ moves: [String: [GameMove]]) {
        mutableState.validMoves = moves
    }
    
    func removePlayer(_ playerId: String) -> PlayerProtocol? {
        mutableState.players.removeFirst(where: { $0.identifier == playerId })
    }
    
    func addEliminated(_ player: PlayerProtocol) {
        mutableState.eliminated.append(player)
    }
    
    func setOutcome(_ outcome: GameOutcome) {
        mutableState.outcome = outcome
    }
    
    func addDamageEvent(_ event: DamageEvent) {
        mutableState.damageEvents.append(event)
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
        player(playerId)?.health = health
    }
    
    func playerAddHand(_ playerId: String, _ card: CardProtocol) {
        player(playerId)?.hand.append(card)
    }
    
    func playerRemoveHand(_ playerId: String, _ cardId: String) -> CardProtocol? {
        player(playerId)?.hand.removeFirst(where: { $0.identifier == cardId })
    }
    
    func playerAddInPlay(_ playerId: String, _ card: CardProtocol) {
        player(playerId)?.inPlay.append(card)
    }
    
    func playerRemoveInPlay(_ playerId: String, _ cardId: String) -> CardProtocol? {
        player(playerId)?.inPlay.removeFirst(where: { $0.identifier == cardId })
    }
}

private extension MemoryCachedDataBase {
    func player(_ playerId: String) -> Player? {
        mutableState.players.first(where: { $0.identifier == playerId }) as? Player
    }
}
