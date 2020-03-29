//
//  GameState+Observed.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension GameStateProtocol {
    
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
