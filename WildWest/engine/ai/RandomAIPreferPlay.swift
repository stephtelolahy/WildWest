//
//  RandomAIPreferPlay.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 16/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class RandomAIPreferPlay: AIProtocol {
    func evaluate(_ move: ActionProtocol, in state: GameStateProtocol) -> Int {
        
        // prefer play instead of do nothing
        if move is EndTurn {
            return -1
        }
        
        // prefer reaction instead of do nothing
        if move is LooseLife {
            return -1
        }
        
        // prefer use barrel instead of discard card
        if move is UseBarrel {
            return 1
        }
        
        // prefer use larger range gun
        if let equip = move as? Equip {
            if let actor = state.players.first(where: { $0.identifier == equip.actorId }),
                let card = actor.hand.first(where: { $0.identifier == equip.cardId }),
                card.isGun,
                let currentGun = actor.inPlay.first(where: { $0.isGun }),
                currentGun.reachableDistance > card.reachableDistance {
                return -1
            }
        }
        
        return 0
    }
}
