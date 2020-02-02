//
//  LooseLife.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct LooseLife: ActionProtocol, Equatable {
    
    let actorId: String
    
    var description: String {
        "\(actorId) looses life point"
    }
    
    func execute(in state: GameStateProtocol) {
    }
}

struct LooseLifeRule: RuleProtocol, Equatable {
    
    let actionName: String = "Loose life point"
    
    func match(with state: GameStateProtocol) -> [ActionProtocol] {
        guard case let .shoot(targetIds) = state.challenge else {
            return  []
        }
        
        guard let actor = state.players.first(where: { $0.identifier == targetIds.first }) else {
            return []
        }
        
        return [LooseLife(actorId: actor.identifier)]
    }
}
