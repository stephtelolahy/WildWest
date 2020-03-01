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
    private let effectRules: [EffectRuleProtocol]
    
    init(database: GameDatabaseProtocol,
         rules: [RuleProtocol],
         effectRules: [EffectRuleProtocol]) {
        self.database = database
        self.rules = rules
        self.effectRules = effectRules
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
        database.setValidMoves([])
        var moves: [ActionProtocol] = [action]
        
        while !moves.isEmpty {
            let move = moves.remove(at: 0)
            database.addMove(move)
            
            print("\n*** \(move.description) ***")
            let updates = move.execute(in: database.state)
            updates.forEach {
                $0.execute(in: database)
                print($0.description)
            }
            
            guard database.state.outcome == nil else {
                break
            }
            
            let effects = effectRules.compactMap { $0.effectOnExecuting(action: move, in: database.state) }
            if !effects.isEmpty {
                moves.append(contentsOf: effects)
                continue
            }
            
            let validMoves = rules.compactMap { $0.match(with: database.state) }.flatMap { $0 }
            let autoPlayMoves = validMoves.filter({ $0.autoPlay })
            if !autoPlayMoves.isEmpty {
                moves.append(contentsOf: autoPlayMoves)
            } else {
                database.setValidMoves(validMoves)
            }
        }
        
        stateSubject.onNext(database.state)
    }
}
