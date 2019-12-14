//
//  GameState.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol GameStateProtocol {
    var game: Game { get set }
}

class SimpleGameState: GameStateProtocol {
    
    var game: Game
    
    init(_ game: Game) {
        self.game = game
    }
}
