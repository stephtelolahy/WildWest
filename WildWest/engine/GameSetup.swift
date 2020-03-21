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
        var deck = cards
        let players: [Player] = roles.enumerated().map { index, role in
            let figure = figures[index]
            let health = role == .sheriff ? figure.bullets + 1 : figure.bullets
            let hand: [CardProtocol] = Array(1...health).map { _ in deck.removeFirst() }
            return Player(role: role,
                          ability: figure.ability,
                          maxHealth: health,
                          imageName: figure.imageName,
                          health: health,
                          hand: hand,
                          inPlay: [])
        }
        
        return GameState(players: players,
                         deck: deck,
                         discardPile: [],
                         turn: nil,
                         challenge: nil,
                         bangsPlayed: 0,
                         barrelsResolved: 0,
                         damageEvents: [],
                         generalStore: [],
                         outcome: nil,
                         validMoves: [:],
                         executedMoves: [],
                         eliminated: [])
    }
}
