//
//  StartTurn.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct StartTurn: ActionProtocol, Equatable {
    var actorId: String
    
    var description: String {
        "\(actorId) start turn"
    }
    
    func execute(in state: GameStateProtocol) {
        state.setChallenge(nil)
        state.setTurnShoots(0)
        state.pullFromDeck(playerId: actorId)
        state.pullFromDeck(playerId: actorId)
    }
}

struct StartTurnRule: RuleProtocol {
    
    let actionName: String = "StartTurn"
    
    func match(with state: GameStateProtocol) -> [ActionProtocol] {
        guard case .startTurn = state.challenge else {
            return []
        }
        
        let actor = state.players[state.turn]
        return [StartTurn(actorId: actor.identifier)]
    }
}
