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
    private let calculator: OutcomeCalculatorProtocol
    
    init(state: GameStateProtocol,
         mutableState: MutableGameStateProtocol,
         rules: [RuleProtocol],
         calculator: OutcomeCalculatorProtocol) {
        self.state = state
        self.mutableState = mutableState
        self.rules = rules
        self.calculator = calculator
        stateSubject = BehaviorSubject(value: state)
    }
    
    func execute(_ command: ActionProtocol) {
        let updates = command.execute(in: state)
        updates.forEach { $0.execute(in: mutableState) }
        mutableState.addCommand(command)
        if let outcome = calculator.outcome(for: state.players.map { $0.role }) {
            mutableState.setOutcome(outcome)
            mutableState.setActions([])
        } else {
            let actions = rules.compactMap { $0.match(with: state) }.flatMap { $0 }
            mutableState.setActions(actions)
        }
        
        stateSubject.onNext(state)
    }
}
