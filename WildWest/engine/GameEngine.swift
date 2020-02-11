//
//  GameEngine.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

class GameEngine: GameEngineProtocol {
    
    let stateSubject: BehaviorSubject<GameStateProtocol>
    
    private let state: GameStateProtocol
    private let mutableState: MutableGameStateProtocol
    private let rules: [RuleProtocol]
    
    init(state: GameStateProtocol, mutableState: MutableGameStateProtocol, rules: [RuleProtocol]) {
        self.state = state
        self.mutableState = mutableState
        self.rules = rules
        stateSubject = BehaviorSubject(value: state)
    }
    
    func execute(_ command: ActionProtocol) {
        let updates = command.execute(in: state)
        updates.forEach { $0.execute(in: mutableState) }
        mutableState.addCommand(command)
        mutableState.setActions(actions(matching: state))
        stateSubject.onNext(state)
    }
    
    private func actions(matching state: GameStateProtocol) -> [ActionProtocol] {
        guard state.outcome == nil else {
            return []
        }
        
        return rules.compactMap { $0.match(with: state) }.flatMap { $0 }
    }
}
