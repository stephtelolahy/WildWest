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
    
    private let rules: [RuleProtocol]
    
    init(state: GameStateProtocol, rules: [RuleProtocol]) {
        stateSubject = BehaviorSubject(value: state)
        self.rules = rules
    }
    
    func execute(_ action: ActionProtocol) {
        guard let state = try? stateSubject.value() else {
            return
        }
        
        action.execute(in: state)
        state.addCommand(action)
        state.setActions(rules.compactMap { $0.match(with: state) }.flatMap { $0 })
        stateSubject.onNext(state)
    }
}
