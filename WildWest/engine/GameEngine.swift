//
//  GameEngine.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/13/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

protocol GameEngineProtocol {
    func run()
}

class GameEngine {
    
    private let state: GameStateProtocol
    private let rules: GameRulesProtocol
    private let aiPlayer: GameAIProtocol
    private let renderer: GameRendererProtocol
    
    init(state: GameStateProtocol, rules: GameRulesProtocol, aiPlayer: GameAIProtocol, renderer: GameRendererProtocol) {
        self.state = state
        self.rules = rules
        self.aiPlayer = aiPlayer
        self.renderer = renderer
    }
    
    func run() {
        while true {
            let game = state.state()
            guard !rules.isOver(game) else {
                break
            }
            
            let actions = rules.possibleActions(game)
            let action = aiPlayer.choose(actions)
            // TODO: perform game update sequentially
            let result = action.execute(game)
            state.update(result)
            renderer.render(result)
        }
    }
}
