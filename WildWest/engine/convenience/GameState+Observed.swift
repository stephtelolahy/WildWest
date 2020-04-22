//
//  GameState+Observed.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 29/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

extension GameStateProtocol {
    
    func observed(by playerId: String?) -> GameStateProtocol {
        GameState(allPlayers: allPlayers.map { $0.observed(by: playerId, in: self) },
                  deck: deck,
                  discardPile: discardPile,
                  turn: turn,
                  challenge: challenge,
                  generalStore: generalStore,
                  outcome: outcome)
    }
}

private extension PlayerProtocol {
    func observed(by playerId: String?, in state: GameStateProtocol) -> PlayerProtocol {
        let shouldHideRole = health > 0
            && identifier != playerId
            && role != .sheriff
            && state.outcome == nil
        return Player(role: shouldHideRole ? nil : role,
                      figureName: figureName,
                      imageName: imageName,
                      description: description,
                      abilities: abilities,
                      maxHealth: maxHealth,
                      health: health,
                      hand: hand,
                      inPlay: inPlay,
                      bangsPlayed: bangsPlayed,
                      lastDamage: lastDamage)
    }
}
