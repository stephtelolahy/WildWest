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
    
    init(state: GameStateProtocol, rules: GameRulesProtocol) {
        self.state = state
        self.rules = rules
    }
    
    func run() {
        while state.outcome == nil {
            let actions = rules.possibleActions(state)
            let action = actions[0]
            let updates = action.execute()
            updates.forEach { $0.apply(to: state) }
            print(state)
        }
    }
}
