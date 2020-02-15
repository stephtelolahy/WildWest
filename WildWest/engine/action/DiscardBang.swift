//
//  DiscardBang.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct DiscardBang: ActionProtocol, Equatable {
    let actorId: String
    let cardId: String
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        var updates: [GameUpdate] = []
        updates.append(.playerDiscardHand(actorId, cardId))
        
        if case let .duel(playerIds) = state.challenge {
            let permutedPlayerIds = [playerIds[1], playerIds[0]]
            updates.append(.setChallenge(.duel(permutedPlayerIds)))
        } else {
            updates.append(.setChallenge(state.challenge?.removing(actorId)))
        }
        return updates
    }
    
    var description: String {
        "\(actorId) discards \(cardId)"
    }
}

struct DiscardBangRule: RuleProtocol {
    
    func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        var actorId: String?
        switch state.challenge {
        case let .indians(targetIds):
            actorId = targetIds.first
            
        case let .duel(playerIds):
            actorId = playerIds.first
            
        default:
            break
        }
        
        guard let actor = state.players.first(where: { $0.identifier == actorId }),
            let cards = actor.handCards(named: .bang) else {
                return nil
        }
        
        return cards.map { DiscardBang(actorId: actor.identifier, cardId: $0.identifier) }
    }
}
