//
//  StartTurn.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct StartTurn: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String = ""
    
    var description: String {
        "\(actorId) starts turn"
    }
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        let updates: [GameUpdate] = [.setChallenge(nil),
                                     .setBangsPlayed(0),
                                     .playerPullCardFromDeck(actorId),
                                     .playerPullCardFromDeck(actorId)]
        return updates
    }
}

struct StartTurnRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        guard case .startTurn = state.challenge,
            let actor = state.players.first(where: { $0.identifier == state.turn }),
            actor.inPlayCards(named: .jail).isEmpty else {
                return nil
        }
        
        return [StartTurn(actorId: actor.identifier)]
    }
}
