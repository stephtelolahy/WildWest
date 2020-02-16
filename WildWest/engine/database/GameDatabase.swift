//
//  GameDatabase.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 10/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension GameState: GameDatabaseProtocol {
    
    var state: GameStateProtocol {
        self
    }
    
    // Flags
    
    func setTurn(_ turn: String) {
        self.turn = turn
    }
    
    func setChallenge(_ challenge: Challenge?) {
        self.challenge = challenge
    }
    
    func setBangsPlayed(_ bangsPlayed: Int) {
        self.bangsPlayed = bangsPlayed
    }
    
    func setBarrelsResolved(_ barrelsResolved: Int) {
        self.barrelsResolved = barrelsResolved
    }
    
    func addCommandsHistory(_ actions: ActionProtocol) {
        commandsHistory.append(actions)
    }
    
    func setValidMoves(_ actions: [ActionProtocol]) {
        self.validMoves = actions
    }
    
    func removePlayer(_ playerId: String) -> PlayerProtocol? {
        players.removeFirst(where: { $0.identifier == playerId })
    }
    
    func addEliminated(_ player: PlayerProtocol) {
        eliminated.append(player)
    }
    
    func setOutcome(_ outcome: GameOutcome) {
        self.outcome = outcome
    }
    
    /// Deck
    
    func deckRemoveFirst() -> CardProtocol {
        deck.removeFirst()
    }
    
    func addDiscard(_ card: CardProtocol) {
        deck.append(card)
    }
    
    func addGeneralStore(_ card: CardProtocol) {
        generalStore.append(card)
    }
    
    func removeGeneralStore(_ cardId: String) -> CardProtocol? {
        generalStore.removeFirst(where: { $0.identifier == cardId })
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
    
    func playerRemoveAllHand(_ playerId: String) -> [CardProtocol] {
        guard let player = player(playerId) else {
            return []
        }
        
        let cards = player.hand
        player.hand.removeAll()
        return cards
    }
    
    func playerRemoveAllInPlay(_ playerId: String) -> [CardProtocol] {
        guard let player = player(playerId) else {
            return []
        }
        
        let cards = player.inPlay
        player.inPlay.removeAll()
        return cards
    }
}

private extension GameState {
    func player(_ playerId: String) -> Player? {
        players.first(where: { $0.identifier == playerId }) as? Player
    }
}
