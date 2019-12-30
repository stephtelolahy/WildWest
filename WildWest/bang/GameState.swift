//
//  GameState.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/23/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class GameState: GameStateProtocol {
    
    let players: [PlayerProtocol]
    let deck: CardListProtocol
    let discard: CardListProtocol
    var turn: Int
    var outcome: GameOutcome?
    var messages: [String]
    
    init(players: [PlayerProtocol], deck: CardListProtocol, discard: CardListProtocol) {
        self.players = players
        self.deck = deck
        self.discard = discard
        turn = 0
        outcome = nil
        messages = []
    }
    
    func addMessage(_ message: String) {
        messages.append(message)
    }
    
    func discard(playerId: String, cardId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }),
            let card = player.hand.cards.first(where: { $0.identifier == cardId }) else {
                return
        }
        
        player.hand.remove(card)
        deck.add(card)
        addMessage("\(player.identifier) discard \(card.identifier)")
    }
    
    func pull(playerId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }) else {
            return
        }
        
        let card = deck.pull()
        player.hand.add(card)
        addMessage("\(player.identifier) pull \(card.identifier) from deck")
    }
    
    func gainLifePoint(playerId: String) {
        guard let player = players.first(where: { $0.identifier == playerId }) else {
            return
        }
        player.gainLifePoint()
        addMessage("\(player.identifier) gain life point")
    }
    
    func matchingCards(playerId: String, cardName: CardName) -> [CardProtocol] {
        guard let player = players.first(where: { $0.identifier == playerId }) else {
            return []
        }
        
        return player.hand.cards.filter({ $0.name == cardName })
    }
}
