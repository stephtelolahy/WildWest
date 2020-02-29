//
//  LooseLife.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct LooseLife: ActionProtocol, Equatable {
    let actorId: String
    let points: Int
    let cardId = ""
    let autoPlay = false
    
    var description: String {
        "\(actorId) looses \(points) life points"
    }
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        guard let player = state.players.first(where: { $0.identifier == actorId }),
            let challenge = state.challenge,
            let damageSource = challenge.damageSource else {
                return []
        }
        
        let updates: [GameUpdate] = [
            .playerLooseHealth(actorId, player.health - points, damageSource),
            .setChallenge(challenge.removing(actorId))
        ]
        return updates
    }
}

struct LooseLifeRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        switch state.challenge {
        case let .shoot(targetIds, _, _):
            return [LooseLife(actorId: targetIds[0], points: 1)]
            
        case let .indians(targetIds, _):
            return [LooseLife(actorId: targetIds[0], points: 1)]
            
        case let .duel(playerIds, _):
            return [LooseLife(actorId: playerIds[0], points: 1)]
            
        case .startTurnDynamiteExploded:
            return [LooseLife(actorId: state.turn, points: 3)]
            
        default:
            return nil
        }
    }
}
