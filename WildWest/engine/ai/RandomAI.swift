//
//  RandomAI.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 16/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class RandomAI: AIProtocol {
    func evaluate(_ move: GameMove, in state: GameStateProtocol) -> Int {
        
        // prefer play instead of ending turn
        if case .endTurn = move.name {
            return Score.endTurn
        }
        
        // prefer reaction instead of do nothing
        if case .pass = move.name {
            return Score.pass
        }
        
        // prefer play larger range gun
        if case .play = move.name,
            let cardName = move.cardName,
            cardName.isGun,
            let actor = state.players.first(where: { $0.identifier == move.actorId }) {
            let currentGunRange = actor.inPlay.first(where: { $0.name.isGun })?.name.reachableDistance ?? 0
            let handGunRange = cardName.reachableDistance
            return handGunRange - currentGunRange
        }
        
        return 0
    }
}
