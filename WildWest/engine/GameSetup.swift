//
//  GameSetup.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class GameSetup: GameSetupProtocol {
    
    func roles(for playersCount: Int) -> [Role] {
        guard playersCount >= 4 && playersCount <= 7 else {
            return []
        }
        
        let order: [Role] = [.sheriff, .outlaw, .outlaw, .renegade, .deputy, .outlaw, .deputy]
        return Array(order.prefix(playersCount))
    }
    
    func setupGame(roles: [Role], figures: [FigureProtocol], cards: [CardProtocol]) -> GameStateProtocol {
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
                          imageName: figure.imageName,
                          health: health,
                          hand: hand,
                          inPlay: [],
                          actions: [])
        }
        
        if let sheriff = players.first(where: { $0.role == .sheriff }) {
            sheriff.setActions([StartTurn(actorId: sheriff.identifier)])
        }
        
        return GameState(players: players,
                         deck: Deck(cards: deck, discardPile: []),
                         turn: 0,
                         challenge: nil,
                         outcome: nil,
                         commands: [])
    }
}
