//
//  GameState+Observed.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension GameStateProtocol {
    
    func observed(by playerId: String?) -> GameStateProtocol {
        let updatedPlayers = allPlayers.map { player -> PlayerProtocol in
            let shouldHideRole = player.health > 0
                && player.identifier != playerId
                && player.role != .sheriff
                && outcome == nil
            let role: Role? = shouldHideRole ? nil : player.role
            return Player(role: role,
                          figureName: player.figureName,
                          imageName: player.imageName,
                          description: player.description,
                          abilities: player.abilities,
                          maxHealth: player.maxHealth,
                          health: player.health,
                          hand: player.hand,
                          inPlay: player.inPlay,
                          bangsPlayed: player.bangsPlayed,
                          lastDamage: player.lastDamage)
        }
        return GameState(allPlayers: updatedPlayers,
                         deck: deck,
                         discardPile: discardPile,
                         turn: turn,
                         challenge: challenge,
                         generalStore: generalStore,
                         outcome: outcome,
                         validMoves: validMoves,
                         executedMoves: executedMoves)
    }
}
