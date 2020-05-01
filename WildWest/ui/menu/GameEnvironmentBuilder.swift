//
//  GameEnvironmentBuilder.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/05/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable force_cast

import RxSwift

struct GameEnvironment {
    let engine: GameEngine
    let subjects: GameSubjects
    let controlledId: String?
    let aiAgents: [AIPlayerAgent]
}

class GameEnvironmentBuilder {
    
    func createLocalEnvironment(state: GameStateProtocol, controlledId: String?) -> GameEnvironment {
        let stateSubject: BehaviorSubject<GameStateProtocol> = BehaviorSubject(value: state)
        let executedMoveSubject = PublishSubject<GameMove>()
        let executedUpdateSubject = PublishSubject<GameUpdate>()
        let validMovesSubject = PublishSubject<[GameMove]>()
        
        let database = MemoryCachedDataBase(mutableState: state as! GameState,
                                            stateSubject: stateSubject,
                                            executedMoveSubject: executedMoveSubject,
                                            executedUpdateSubject: executedUpdateSubject,
                                            validMovesSubject: validMovesSubject)
        
        let subjects = GameSubjects(stateSubject: stateSubject,
                                    executedMoveSubject: executedMoveSubject,
                                    executedUpdateSubject: executedUpdateSubject,
                                    validMovesSubject: validMovesSubject)
        
        let engine = GameEngine(delay: UserPreferences.shared.updateDelay,
                                database: database,
                                stateSubject: stateSubject,
                                moveMatchers: GameRules().moveMatchers,
                                updateExecutor: GameUpdateExecutor(),
                                subjects: subjects)
        
        let controlledPlayerId: String? = UserPreferences.shared.simulationMode ? nil : state.players.first?.identifier
        
        let aiPlayers = state.players.filter { $0.identifier != controlledPlayerId }
        let aiAgents = aiPlayers.map { AIPlayerAgent(playerId: $0.identifier,
                                                     ai: RandomAIWithRole(),
                                                     engine: engine,
                                                     subjects: subjects)
        }
        
        aiAgents.forEach { $0.observeState() }
        
        return GameEnvironment(engine: engine,
                               subjects: subjects,
                               controlledId: controlledPlayerId,
                               aiAgents: aiAgents)
    }
    
    func createRemoteEnvironment(gameId: String, state: GameStateProtocol) -> GameEnvironment {
        fatalError()
    }
}
