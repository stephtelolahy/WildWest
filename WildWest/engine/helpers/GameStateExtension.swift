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
    
    func observed(by playerId: String?) -> GameStateProtocol {
        let updatedPlayers = players.map { player -> PlayerProtocol in
            let shouldHideRole = player.identifier != playerId && player.role != .sheriff && outcome == nil
            let role: Role? = shouldHideRole ? nil : player.role
            return Player(role: role,
                          ability: player.ability,
                          maxHealth: player.maxHealth,
                          imageName: player.imageName,
                          health: player.health,
                          hand: player.hand,
                          inPlay: player.inPlay)
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
