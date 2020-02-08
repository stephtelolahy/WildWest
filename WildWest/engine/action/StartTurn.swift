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
        state.setBangsPlayed(0)
        state.pullDeck(playerId: actorId)
        state.pullDeck(playerId: actorId)
    }
}

struct StartTurnRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [GenericAction]? {
        guard case .startTurn = state.challenge,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            actor.inPlayCards(named: .jail).isEmpty else {
                return nil
        }
        
        return [GenericAction(name: "startTurn",
                              actorId: state.turn,
                              cardId: nil,
                              options: [StartTurn(actorId: state.turn)])]
    }
}
