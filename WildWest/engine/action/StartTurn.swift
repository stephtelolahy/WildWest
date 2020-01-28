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
    
    func execute(state: GameStateProtocol) {
        state.pullFromDeck(playerId: actorId)
        state.pullFromDeck(playerId: actorId)
    }
}

extension StartTurn: RuleProtocol {
    
    static func match(state: GameStateProtocol) -> [StartTurn] {
        return []
    }
}
