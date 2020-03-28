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
    
    func hidingRoles(except playerId: String?) -> GameStateProtocol {
        let updatedPlayers = players.map {
            $0.hidingRole(where: $0.identifier != playerId && $0.role != .sheriff && outcome == nil)
        }
        return GameState(players: updatedPlayers,
                         deck: deck,
                         discardPile: discardPile,
                         turn: turn,
                         challenge: challenge,
                         bangsPlayed: bangsPlayed,
                         barrelsResolved: barrelsResolved,
                         damageEvents: damageEvents,
                         generalStore: generalStore,
                         outcome: outcome,
                         validMoves: validMoves,
                         executedMoves: executedMoves,
                         eliminated: eliminated)
    }
}

private extension PlayerProtocol {
    func hidingRole(where condition: Bool) -> PlayerProtocol {
        Player(role: condition ? nil : role,
               ability: ability,
               maxHealth: maxHealth,
               imageName: imageName,
               health: health,
               hand: hand,
               inPlay: inPlay)
    }
}
