//
//  GameStateExtension.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 09/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension GameStateProtocol {
    
    func discardableCards(from actor: PlayerProtocol, and otherPlayers: [PlayerProtocol]) -> [DiscardableCard]? {
        var result: [DiscardableCard] = []
        result += actor.inPlay.map { DiscardableCard(cardId: $0.identifier,
                                                     ownerId: actor.identifier,
                                                     source: .inPlay)
        }
        
        for player in otherPlayers {
            result += player.hand.map { DiscardableCard(cardId: $0.identifier,
                                                        ownerId: player.identifier,
                                                        source: .hand)
                
            }
            
            result += player.inPlay.map { DiscardableCard(cardId: $0.identifier,
                                                          ownerId: player.identifier,
                                                          source: .inPlay)
            }
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
        case let .startTurn(playerId):
            return "startTurn(\(playerId))"
        case let .duel(playerIds):
            return "duel(\(playerIds.joined(separator: ", ")))"
        case let .shoot(playerIds):
            return "shoot(\(playerIds.joined(separator: ", ")))"
        case let .indians(playerIds):
            return "indians(\(playerIds.joined(separator: ", ")))"
        case let .generalStore(playerIds):
            return "generalStore(\(playerIds.joined(separator: ", ")))"
        case let .dynamiteExplode(playerId):
            return "dynamiteExplode(\(playerId))"
        }
    }
}
