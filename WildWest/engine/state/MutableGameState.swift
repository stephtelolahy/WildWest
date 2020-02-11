//
//  MutableGameState.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 10/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension GameState: MutableGameStateProtocol {
    
    func setTurn(_ turn: String) {
        self.turn = turn
    }
    
    func setChallenge(_ challenge: Challenge?) {
        self.challenge = challenge
    }
    
    func setBangsPlayed(_ bangsPlayed: Int) {
        self.bangsPlayed = bangsPlayed
    }
    
    func addCommand(_ command: ActionProtocol) {
        commands.append(command)
    }
    
    func setActions(_ actions: [ActionProtocol]) {
        self.actions = actions
    }
    
    /// Deck
    
    func deckRemoveFirst() -> CardProtocol {
        deck.removeFirst()
    }
    
    func addDiscard(_ card: CardProtocol) {
        deck.append(card)
    }
    
    /// Player
    
    func playerSetHealth(_ playerId: String, _ health: Int) {
        guard let player = players.first(where: { $0.identifier == playerId }) as? Player else {
            return
        }
        
        player.health = health
    }
    
    func playerAddHand(_ playerId: String, _ card: CardProtocol) {
        guard let player = players.first(where: { $0.identifier == playerId }) as? Player else {
            return
        }
        
        player.hand.append(card)
    }
    
    func playerRemoveHand(_ playerId: String, _ cardId: String) -> CardProtocol? {
        guard let player = players.first(where: { $0.identifier == playerId }) as? Player,
            let cardIndex = player.hand.firstIndex(where: { $0.identifier == cardId }) else {
                return nil
        }
        
        return player.hand.remove(at: cardIndex)
    }
    
    func playerAddInPlay(_ playerId: String, _ card: CardProtocol) {
        guard let player = players.first(where: { $0.identifier == playerId }) as? Player else {
            return
        }
        
        player.inPlay.append(card)
    }
    
    func playerRemoveInPlay(_ playerId: String, _ cardId: String) -> CardProtocol? {
        guard let player = players.first(where: { $0.identifier == playerId }) as? Player,
            let cardIndex = player.inPlay.firstIndex(where: { $0.identifier == cardId }) else {
                return nil
        }
        
        return player.inPlay.remove(at: cardIndex)
    }
    
}
