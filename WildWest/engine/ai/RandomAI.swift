//
//  RandomAI.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 16/02/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

class RandomAI: AIProtocol {
    func bestMove(in state: GameStateProtocol) -> ActionProtocol? {
        state.validMoves.randomElement()
    }
}
