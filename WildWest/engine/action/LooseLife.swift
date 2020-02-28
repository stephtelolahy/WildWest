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
        updates.append(.playerSetHealth(actorId, player.health - points))
        if let challenge = state.challenge {
            updates.append(.setChallenge(challenge.removing(actorId)))
        }
        return updates
    }
}

struct LooseLifeRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        switch state.challenge {
        case let .shoot(targetIds, _):
            return [LooseLife(actorId: targetIds[0], points: 1)]
            
        case let .indians(targetIds):
            return [LooseLife(actorId: targetIds[0], points: 1)]
            
        case let .duel(playerIds):
            return [LooseLife(actorId: playerIds[0], points: 1)]
            
        case .startTurnDynamiteExploded:
            return [LooseLife(actorId: state.turn, points: 3)]
            
        default:
            return nil
        }
    }
}
