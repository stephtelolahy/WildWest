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

class GameEngine: GameEngineProtocol {
    
    private var state: GameStateProtocol
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
        while state.outcome == nil {
            let actions = rules.possibleActions(state)
            let action = aiPlayer.choose(actions)
            let updates = action.execute()
            updates.forEach { $0.apply(to: state) }
            renderer.render(state)
        }
    }
}
