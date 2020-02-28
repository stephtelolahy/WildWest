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
    
    private let database: GameDatabaseProtocol
    private let rules: [RuleProtocol]
    private let calculator: OutcomeCalculatorProtocol
    
    init(database: GameDatabaseProtocol,
         rules: [RuleProtocol],
         calculator: OutcomeCalculatorProtocol) {
        self.database = database
        self.rules = rules
        self.calculator = calculator
        stateSubject = BehaviorSubject(value: database.state)
    }
    
    func start() {
        guard let sheriff = database.state.players.first(where: { $0.role == .sheriff }) else {
            return
        }
        
        database.setTurn(sheriff.identifier)
        execute(StartTurn(actorId: sheriff.identifier))
    }
    
    func execute(_ action: ActionProtocol) {
        let updates = action.execute(in: database.state)
        print("\n*** \(action.description) ***")
        updates.forEach {
            $0.execute(in: database)
            print($0.description)
        }
        database.addCommandsHistory(action)
        if let outcome = calculator.outcome(for: database.state.players.map { $0.role }) {
            database.setOutcome(outcome)
            database.setValidMoves([])
        } else {
            let actions = rules.compactMap { $0.match(with: database.state) }.flatMap { $0 }
            database.setValidMoves(actions)
        }
        
        stateSubject.onNext(database.state)
    }
}
