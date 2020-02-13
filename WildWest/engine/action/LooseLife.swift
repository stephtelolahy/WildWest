//
//  LooseLife.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct LooseLife: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String = ""
    
    var description: String {
        "\(actorId) looses life point"
    }
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        guard let player = state.players.first(where: { $0.identifier == actorId }) else {
            return []
        }
        
        var updates: [GameUpdate] = []
        let health = player.health - 1
        if health > 0 {
            updates.append(.playerSetHealth(actorId, health))
            updates.append(.setChallenge(state.challenge?.removing(actorId)))
            return updates
        }
        
        updates.append(.eliminatePlayer(actorId))
        // TODO: update outcome
        // TODO: update turn
        updates.append(.setChallenge(state.challenge?.removing(actorId)))
        return updates
    }
}

struct LooseLifeRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
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
        
        return [LooseLife(actorId: actor.identifier)]
    }
}
