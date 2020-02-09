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
        guard let player = state.players.first(where: { $0.identifier == actorId }) else {
            return
        }
        
        state.setChallenge(state.challenge?.removing(actorId))
        
        if player.health >= 2 {
            state.looseLifePoint(playerId: actorId)
        } else {
            state.eliminate(playerId: actorId)
        }
    }
}

struct LooseLifeRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [GenericAction]? {
        var actorId: String?
        
        switch state.challenge {
        case let .shoot(targetIds):
            actorId = targetIds.first
            
        case let .indians(targetIds):
            actorId = targetIds.first
            
        case let .duel(playerIds):
            actorId = playerIds.first
        default:
            break
        }
        
        guard let actor = state.players.first(where: { $0.identifier == actorId }) else {
            return nil
        }
        
        return [GenericAction(name: "looseLifePoint",
                              actorId: actor.identifier,
                              cardId: nil,
                              options: [LooseLife(actorId: actor.identifier)])]
    }
}
