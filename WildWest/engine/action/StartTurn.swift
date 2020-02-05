//
//  StartTurn.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct StartTurn: ActionProtocol, Equatable {
    let actorId: String
    
    var description: String {
        "\(actorId) start turn"
    }
    
    func execute(in state: GameStateProtocol) {
        state.setChallenge(nil)
        state.setTurnShoots(0)
        state.pullDeck(playerId: actorId)
        state.pullDeck(playerId: actorId)
    }
}

struct StartTurnRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [GenericAction]? {
        guard case .startTurn = state.challenge else {
            return nil
        }
        
        let actor = state.players[state.turn]
        return [GenericAction(name: "startTurn",
                              actorId: actor.identifier,
                              cardId: nil,
                              options: [StartTurn(actorId: actor.identifier)])]
    }
}
