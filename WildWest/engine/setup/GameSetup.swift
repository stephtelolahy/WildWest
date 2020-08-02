//
//  GameSetup.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

class GameSetup: GameSetupProtocol {
    
    func roles(for playersCount: Int) -> [Role] {
        let order: [Role] = [.sheriff, .outlaw, .outlaw, .renegade, .deputy, .outlaw, .deputy]
        
        guard playersCount <= order.count else {
            return []
        }
        
        return Array(order.prefix(playersCount))
    }
    
    func setupGame(roles: [Role], figures: [FigureProtocol], cards: [CardProtocol]) -> GameStateProtocol {
        var deck = cards
        let players: [Player] = roles.enumerated().map { index, role in
            let figure = figures[index]
            let health = role == .sheriff ? figure.bullets + 1 : figure.bullets
            let hand: [CardProtocol] = Array(1...health).map { _ in deck.removeFirst() }
            return Player(identifier: figure.name.rawValue,
                          role: role,
                          figureName: figure.name,
                          imageName: figure.imageName,
                          description: figure.description,
                          abilities: figure.abilities,
                          maxHealth: health,
                          health: health,
                          hand: hand,
                          inPlay: [],
                          bangsPlayed: 0,
                          lastDamage: nil)
        }
        
        guard let sheriff = players.first(where: { $0.role == .sheriff }) else {
            fatalError("Sheriff not found")
        }
        
        return GameState(allPlayers: players,
                         deck: deck,
                         discardPile: [],
                         turn: sheriff.identifier,
                         challenge: Challenge(name: .startTurn),
                         generalStore: [],
                         outcome: nil)
    }
}
