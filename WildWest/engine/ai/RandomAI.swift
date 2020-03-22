//
//  RandomAI.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 16/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class RandomAI: AIProtocol {
    func evaluate(_ move: GameMove, in state: GameStateProtocol) -> Int {
        
        // prefer play instead of do nothing
        if case .endTurn = move.name {
            return Score.endTurn
        }
        
        // prefer reaction instead of do nothing
        if case .pass = move.name {
            return Score.pass
        }
        
        // prefer keep larger range gun
        if case .play = move.name,
            let cardId = move.cardId,
            let actorId = move.actorId,
            let actor = state.players.first(where: { $0.identifier == actorId }),
            let card = actor.hand.first(where: { $0.identifier == cardId }),
            card.name.isGun,
            let currentGun = actor.inPlay.first(where: { $0.name.isGun }),
            currentGun.name.reachableDistance > card.name.reachableDistance {
            return Score.useLowerRangeGun
        }
        
        return 0
    }
}
