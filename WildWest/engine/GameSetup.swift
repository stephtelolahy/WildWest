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
    
    // swiftlint:disable function_body_length
    func setupGame(roles: [Role], figures: [FigureProtocol], cards: [CardProtocol]) -> GameStateProtocol {
        let shuffledFigures = figures.shuffled()
        let shuffledRoles = roles.shuffled()
        var shuffledCards = cards.shuffled()
        let players: [Player] = shuffledRoles.enumerated().map { index, role in
            let figure = shuffledFigures[index]
            var health = figure.bullets
            if role == .sheriff {
                health += 1
            }
            var hand: [CardProtocol] = []
            while hand.count < health {
                hand.append(shuffledCards.removeFirst())
            }
            return Player(role: role,
                          ability: figure.ability,
                          maxHealth: health,
                          imageName: figure.imageName,
                          health: health,
                          hand: hand,
                          inPlay: [])
        }
        
        guard let sheriff = players.first(where: { $0.role == .sheriff }) else {
            fatalError("sheriff not found")
        }
        
        let actions = [StartTurn(actorId: sheriff.identifier)]
        
        return GameState(players: players,
                         deck: shuffledCards,
                         discardPile: [],
                         turn: sheriff.identifier,
                         challenge: nil,
                         bangsPlayed: 0,
                         generalStoreCards: [],
                         outcome: nil,
                         actions: actions,
                         commands: [],
                         eliminated: [])
    }
}
