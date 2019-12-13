//
//  GameState.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/14/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol GameStateProtocol {
    func state() -> Game
    func update(_ game: Game)
}

class SimpleGameState: GameStateProtocol {
    private var game: Game
    
    init(_ game: Game) {
        self.game = game
    }
    
    func state() -> Game {
        return game
    }
    
    func update(_ game: Game) {
        self.game = game
    }
}
