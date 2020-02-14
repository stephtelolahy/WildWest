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
    let points: Int
    
    var description: String {
        "\(actorId) looses \(points) life points"
    }
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        guard let player = state.players.first(where: { $0.identifier == actorId }) else {
            return []
        }
        
        var updates: [GameUpdate] = []
        let health = player.health - points
        if health > 0 {
            updates.append(.playerSetHealth(actorId, health))
        } else {
            updates.append(.eliminatePlayer(actorId))
            
            if actorId == state.turn {
                updates.append(.setTurn(state.nextTurn))
                updates.append(.setChallenge(.startTurn))
                return updates
            }
        }
        
        if let challenge = state.challenge {
            switch challenge {
            case .dynamiteExplode:
                updates.append(.setChallenge(.startTurn))
                
            default:
                updates.append(.setChallenge(challenge.removing(actorId)))
            }
        }
        
        return updates
    }
}

struct LooseLifeRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        switch state.challenge {
        case let .shoot(targetIds):
            return [LooseLife(actorId: targetIds[0], points: 1)]
            
        case let .indians(targetIds):
            return [LooseLife(actorId: targetIds[0], points: 1)]
            
        case let .duel(playerIds):
            return [LooseLife(actorId: playerIds[0], points: 1)]
            
        case let .dynamiteExplode(playerId):
            return [LooseLife(actorId: playerId, points: 3)]
            
        default:
            return nil
        }
    }
}
