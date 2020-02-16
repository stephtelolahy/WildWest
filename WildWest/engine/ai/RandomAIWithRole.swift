//
//  RandomAIWithRole.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 16/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class RandomAIWithRole: RandomAIPreferPlay {
    
    override func evaluate(_ move: ActionProtocol, in state: GameStateProtocol) -> Int {
        
        // TODO: attack ennemies
        // TODO: help allies
        
        return super.evaluate(move, in: state)
    }
}
