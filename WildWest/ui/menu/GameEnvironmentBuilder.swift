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
    
    func createGame(playersCount: Int,
                    cards: [CardProtocol],
                    figures: [FigureProtocol],
                    preferredRole: Role?,
                    preferredFigure: String?) -> GameStateProtocol {
        let gameSetup = GameSetup()
        
        let shuffledRoles = gameSetup.roles(for: playersCount)
            .shuffled()
            .starting(with: preferredRole)
        
        let shuffledFigures = figures
            .shuffled()
            .starting(where: { $0.name.rawValue == preferredFigure })
        
        let shuffledCards = cards.shuffled()
        
        return gameSetup.setupGame(roles: shuffledRoles,
                                   figures: shuffledFigures,
                                   cards: shuffledCards)
    }
    
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
                               aiAgents: aiAgents)
    }
    
    func createRemoteEnvironment(gameId: String, state: GameStateProtocol, controlledId: String?) -> GameEnvironment {
        fatalError()
    }
}
