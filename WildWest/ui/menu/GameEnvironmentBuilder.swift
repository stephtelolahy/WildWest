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
    let engine: GameEngineProtocol
    let subjects: GameSubjectsProtocol
    let controlledId: String?
    let aiAgents: [AIPlayerAgentProtocol]?
    let allowStart: Bool
}

class GameEnvironmentBuilder {
    
    func createLocalEnvironment(state: GameStateProtocol,
                                controlledId: String?,
                                updateDelay: TimeInterval) -> GameEnvironment {
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
        
        let engine = GameEngine(delay: updateDelay,
                                database: database,
                                stateSubject: stateSubject,
                                moveMatchers: GameRules().moveMatchers,
                                updateExecutor: GameUpdateExecutor(),
                                subjects: subjects)
        
        let aiPlayers = state.players.filter { $0.identifier != controlledId }
        let aiAgents = aiPlayers.map { AIPlayerAgent(playerId: $0.identifier,
                                                     ai: RandomAIWithRole(),
                                                     engine: engine,
                                                     subjects: subjects)
        }
        
        aiAgents.forEach { $0.observeState() }
        
        return GameEnvironment(engine: engine,
                               subjects: subjects,
                               controlledId: controlledId,
                               aiAgents: aiAgents,
                               allowStart: true)
    }
    
    func createRemoteEnvironment(gameId: String,
                                 state: GameStateProtocol,
                                 controlledId: String?,
                                 updateDelay: TimeInterval,
                                 firebaseMapper: FirebaseMapperProtocol) -> GameEnvironment {
        let stateSubject: BehaviorSubject<GameStateProtocol> = BehaviorSubject(value: state)
        let executedMoveSubject = PublishSubject<GameMove>()
        let executedUpdateSubject = PublishSubject<GameUpdate>()
        let validMovesSubject = PublishSubject<[GameMove]>()
        
        let gameAdapter: FirebaseGameAdapterProtocol = FirebaseGameAdapter(gameId: gameId, mapper: firebaseMapper)
        let database = RemoteDatabase(gameAdapter: gameAdapter,
                                      stateSubject: stateSubject,
                                      executedMoveSubject: executedMoveSubject,
                                      executedUpdateSubject: executedUpdateSubject,
                                      validMovesSubject: validMovesSubject)
        
        let subjects = GameSubjects(stateSubject: stateSubject,
                                    executedMoveSubject: executedMoveSubject,
                                    executedUpdateSubject: executedUpdateSubject,
                                    validMovesSubject: validMovesSubject)
        
        let engine = GameEngine(delay: updateDelay,
                                database: database,
                                stateSubject: stateSubject,
                                moveMatchers: GameRules().moveMatchers,
                                updateExecutor: GameUpdateExecutor(),
                                subjects: subjects)
        
        let controlledRoleIsSheriff = state.player(controlledId)?.role == .sheriff
        
        if controlledRoleIsSheriff {
            gameAdapter.setStarted { _ in }
        }
        
        return GameEnvironment(engine: engine,
                               subjects: subjects,
                               controlledId: controlledId,
                               aiAgents: nil,
                               allowStart: controlledRoleIsSheriff)
    }
}
