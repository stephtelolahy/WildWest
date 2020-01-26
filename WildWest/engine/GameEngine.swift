//
//  GameEngine.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import RxSwift

protocol GameEngineProtocol {
    var stateSubject: BehaviorSubject<GameStateProtocol> { get }
    
    func execute(_ action: ActionProtocol)
}

class GameEngine: GameEngineProtocol {
    
    let stateSubject: BehaviorSubject<GameStateProtocol>
    private let rules: GameRulesProtocol
    
    init(state: GameStateProtocol, rules: GameRulesProtocol) {
        stateSubject = BehaviorSubject(value: state)
        self.rules = rules
    }
    
    func execute(_ action: ActionProtocol) {
        guard let state = try? stateSubject.value() else {
            return
        }
        
        action.execute(state: state)
        state.addHistory(action)
        state.setActions(rules.generateActions(for: state))
        stateSubject.onNext(state)
    }
}
