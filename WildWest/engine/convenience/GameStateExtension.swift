//
//  GameStateExtension.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 09/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension GameStateProtocol {
    
    func targetCards(from actor: PlayerProtocol, and otherPlayers: [PlayerProtocol]) -> [TargetCard]? {
        var result: [TargetCard] = []
        
        result += actor.inPlay.map { TargetCard(ownerId: actor.identifier, source: .inPlay($0.identifier)) }
        
        otherPlayers.forEach { player in
            if !player.hand.isEmpty {
                result.append(TargetCard(ownerId: player.identifier, source: .randomHand))
            }
            result += player.inPlay.map { TargetCard(ownerId: player.identifier, source: .inPlay($0.identifier)) }
        }
        
        guard !result.isEmpty else {
            return nil
        }
        
        return result
    }
    
    var nextTurn: String {
        guard let turnIndex = players.firstIndex(where: { $0.identifier == turn }) else {
            return ""
        }
        
        let nextPlayerIndex = (turnIndex + 1) % players.count
        return players[nextPlayerIndex].identifier
    }
}

extension Challenge {
    var description: String {
        switch self {
        case .startTurn:
            return "startTurn"
        case .startTurnDynamiteExploded:
            return "dynamiteExploded"
        case let .duel(playerIds):
            return "duel(\(playerIds.joined(separator: ", ")))"
        case let .shoot(playerIds):
            return "shoot(\(playerIds.joined(separator: ", ")))"
        case let .indians(playerIds):
            return "indians(\(playerIds.joined(separator: ", ")))"
        case let .generalStore(playerIds):
            return "generalStore(\(playerIds.joined(separator: ", ")))"
        }
    }
}
