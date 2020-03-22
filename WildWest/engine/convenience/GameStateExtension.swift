//
//  GameStateExtension.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 09/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension GameStateProtocol {
    
    func targetCards(from otherPlayers: [PlayerProtocol]) -> [TargetCard]? {
        var result: [TargetCard] = []
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
