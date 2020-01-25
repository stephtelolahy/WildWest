//
//  GameSetup.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol GameSetupProtocol {
    func roles(for playersCount: Int) -> [Role]
    func setupGame(roles: [Role], figures: [Figure], cards: [CardProtocol]) -> GameStateProtocol
}

class GameSetup: GameSetupProtocol {
    
    func roles(for playersCount: Int) -> [Role] {
        guard playersCount >= 4 && playersCount <= 7 else {
            return []
        }
        
        let order: [Role] = [.sheriff, .outlaw, .outlaw, .renegade, .deputy, .outlaw, .deputy]
        return Array(order.prefix(playersCount))
    }
    
    func setupGame(roles: [Role], figures: [Figure], cards: [CardProtocol]) -> GameStateProtocol {
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
                          figure: figure,
                          maxHealth: health,
                          health: health,
                          hand: CardList(cards: hand),
                          inPlay: CardList(cards: []))
        }
        
        var actions: [ActionProtocol] = []
        if let sheriff = players.first(where: { $0.role == .sheriff }) {
            actions.append(StartTurn(actorId: sheriff.identifier))
        }
        
        return GameState(players: players,
                         deck: CardList(cards: deck),
                         discard: CardList(cards: []),
                         turn: 0,
                         outcome: nil,
                         history: [],
                         actions: actions)
    }
}
