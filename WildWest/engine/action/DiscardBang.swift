//
//  DiscardBang.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 02/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

struct DiscardBang: PlayCardAtionProtocol, Equatable {
    let actorId: String
    let cardId: String
    let autoPlay = false
    
    func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        var updates: [GameUpdate] = []
        updates.append(.playerDiscardHand(actorId, cardId))
        
        if case let .duel(playerIds, source) = state.challenge {
            let permutedPlayerIds = [playerIds[1], playerIds[0]]
            updates.append(.setChallenge(.duel(permutedPlayerIds, source)))
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
        case let .indians(targetIds, _):
            actorId = targetIds.first
            
        case let .duel(playerIds, _):
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
