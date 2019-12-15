//
//  GameEngine.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/13/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol GameEngineProtocol {
    func run(state: GameStateProtocol)
    func possibleActions(_ game: GameStateProtocol) -> [GameActionProtocol]
}

class GameEngine: GameEngineProtocol {
    
    func run(state: GameStateProtocol) {
        while state.outcome == nil {
            let actions = possibleActions(state)
            let action = actions[0]
            let updates = action.execute()
            updates.forEach { $0.apply(to: state) }
            print(state)
        }
    }
    
    func possibleActions(_ game: GameStateProtocol) -> [GameActionProtocol] {
        let player = game.players[game.turn]
        var actions: [GameActionProtocol] = []
        for card in player.hand.cards {
            switch card.name {
            case .beer:
                actions.append(Beer(playerIdentifier: player.identifier, cardIdentifier: card.identifier))
            default:
                break
            }
        }
        return actions
    }
}
