//
//  GameBuilder.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable force_cast

import UIKit
import RxSwift
import Firebase

protocol GameBuilderProtocol {
    func createGame(for playersCount: Int) -> GameStateProtocol
    func createLocalGameEnvironment(state: GameStateProtocol,
                                    playerId: String?) -> GameEnvironment
    func createRemoteGameEnvironment(gameId: String,
                                     playerId: String?,
                                     state: GameStateProtocol,
                                     users: [String: WUserInfo]) -> GameEnvironment
}

class GameBuilder: GameBuilderProtocol, Subscribable {
    
    private let preferences: UserPreferencesProtocol
    private let gameResources: GameResourcesProtocol
    private let firebaseMapper: FirebaseMapperProtocol
    
    init(preferences: UserPreferencesProtocol,
         gameResources: GameResourcesProtocol,
         firebaseMapper: FirebaseMapperProtocol) {
        self.preferences = preferences
        self.gameResources = gameResources
        self.firebaseMapper = firebaseMapper
    }
    
    func createGame(for playersCount: Int) -> GameStateProtocol {
        let gameSetup = GameSetup()
        
        let figures = gameResources.allFigures
        let shuffledRoles = gameSetup.roles(for: playersCount)
            .shuffled()
            .starting(with: preferences.preferredRole)
        
        let shuffledFigures = figures
            .shuffled()
            .starting(where: { $0.name == preferences.preferredFigure })
        
        let cards = gameResources.allCards
        let shuffledCards = cards.shuffled()
        
        return gameSetup.setupGame(roles: shuffledRoles,
                                   figures: shuffledFigures,
                                   cards: shuffledCards)
    }
    
    func createLocalGameEnvironment(state: GameStateProtocol,
                                    playerId: String?) -> GameEnvironment {
        let stateSubject = BehaviorSubject<GameStateProtocol>(value: state)
        let executedMoveSubject = PublishSubject<GameMove>()
        let executedUpdateSubject = PublishSubject<GameUpdate>()
        let validMovesSubject = BehaviorSubject<[GameMove]>(value: [])
        
        let database = LocalGameDataBase(mutableState: state as! GameState,
                                         stateSubject: stateSubject,
                                         executedMoveSubject: executedMoveSubject,
                                         executedUpdateSubject: executedUpdateSubject,
                                         validMovesSubject: validMovesSubject)
        
        let subjects = GameSubjects(stateSubject: stateSubject,
                                    executedMoveSubject: executedMoveSubject,
                                    executedUpdateSubject: executedUpdateSubject,
                                    validMovesSubject: validMovesSubject)
        
        let engine = GameEngine(delay: preferences.updateDelay,
                                database: database,
                                moveMatchers: GameRules().moveMatchers)
        
        let aiPlayers = state.players.filter { $0.identifier != playerId }
        let aiAgents: [AIPlayerAgentProtocol] = aiPlayers.map { player in
            let moveClassifier = MoveClassifier()
            let statsBuilder = StatsBuilder(sheriffId: subjects.sheriffId, classifier: moveClassifier)
            let roleEstimator = RoleEstimator(statsBuilder: statsBuilder)
            let ai = RandomAIWithRole(classifier: moveClassifier, roleEstimator: roleEstimator)
            return AIPlayerAgent(playerId: player.identifier,
                                 ai: ai,
                                 engine: engine,
                                 subjects: subjects,
                                 statsBuilder: statsBuilder)
        }
        aiAgents.forEach { $0.observeState() }
        
        return GameEnvironment(engine: engine,
                               subjects: subjects,
                               controlledId: playerId,
                               aiAgents: aiAgents)
    }
    
    func createRemoteGameEnvironment(gameId: String,
                                     playerId: String?,
                                     state: GameStateProtocol,
                                     users: [String: WUserInfo]) -> GameEnvironment {
        let stateSubject = BehaviorSubject<GameStateProtocol>(value: state)
        let executedMoveSubject = PublishSubject<GameMove>()
        let executedUpdateSubject = PublishSubject<GameUpdate>()
        let validMovesSubject = BehaviorSubject<[GameMove]>(value: [])
        
        let gameRef = Database.database().reference().child("games/\(gameId)")
        let database = RemoteGameDatabase(gameRef: gameRef,
                                          mapper: firebaseMapper,
                                          stateSubject: stateSubject,
                                          executedMoveSubject: executedMoveSubject,
                                          executedUpdateSubject: executedUpdateSubject,
                                          validMovesSubject: validMovesSubject)
        
        let subjects = GameSubjects(stateSubject: stateSubject,
                                    executedMoveSubject: executedMoveSubject,
                                    executedUpdateSubject: executedUpdateSubject,
                                    validMovesSubject: validMovesSubject)
        
        let engine = GameEngine(delay: preferences.updateDelay,
                                database: database,
                                moveMatchers: GameRules().moveMatchers)
        
        return GameEnvironment(engine: engine,
                               subjects: subjects,
                               controlledId: playerId,
                               aiAgents: nil,
                               gameUsers: users)
    }
}
