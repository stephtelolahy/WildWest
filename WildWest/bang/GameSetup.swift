//
//  GameSetup.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/30/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol GameSetupProtocol {
    func setupGame(playersCount: Int, cards: [CardProtocol]) -> GameStateProtocol
}

class GameSetup: GameSetupProtocol {
    
    func setupGame(playersCount: Int, cards: [CardProtocol]) -> GameStateProtocol {
//        let shuffledRoles = gameRules.roles(for: playersCount).shuffled()
//        let shuffledFigures = resourcesManager.allFigures().shuffled()
//        var deck = resourcesManager.allCards().shuffled()
//        let players: [Player] = shuffledRoles.enumerated().map { index, role in
//            let figure = shuffledFigures[index]
//            let health = gameRules.initialHealth(for: figure, role: role)
//            let revealed = gameRules.initialReveal(for: role)
//            var hand: [Card] = []
//            while hand.count < health {
//                hand.append(deck.removeFirst())
//            }
//            return Player(role: role,
//                          revealed: revealed,
//                          figure: figure,
//                          maxHealth: health,
//                          health: health,
//                          gun: .colt45,
//                          hand: hand,
//                          inPlay: [],
//                          turn: gameRules.initialTurn(for: role))
//        }
//        return GameState(players: players, deck: deck, discard: [])
        
        return GameState(players: [], deck: CardList(cards: cards), discard: CardList(cards: []))
    }
}
