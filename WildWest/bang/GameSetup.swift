//
//  GameSetup.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol GameSetupProtocol {
    func setupGame(roles: [Role], figures: [Figure], cards: [CardProtocol]) -> MutableGameStateProtocol
}

class GameSetup: GameSetupProtocol {
    
    func setupGame(roles: [Role], figures: [Figure], cards: [CardProtocol]) -> MutableGameStateProtocol {
        let shuffledFigures = figures.shuffled()
        var deck = cards.shuffled()
        let players: [Player] = roles.enumerated().map { index, role in
            let figure = shuffledFigures[index]
            var health = figure.bullets
            if role == .sheriff {
                health += 1
            }
            var hand: [CardProtocol] = []
            while hand.count < health {
                hand.append(deck.removeFirst())
            }
            return Player(role: role,
                          ability: figure.ability,
                          maxHealth: health,
                          health: health,
                          hand: CardList(cards: hand),
                          inPlay: CardList(cards: []))
        }
        return GameState(players: players, deck: CardList(cards: deck), discard: CardList(cards: []))
    }
}
