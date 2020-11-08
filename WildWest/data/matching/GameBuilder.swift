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
import CardGameEngine

protocol GameBuilderProtocol {
    func createGame(for playersCount: Int) -> StateProtocol
    func createLocalGameEnvironment(state: StateProtocol,
                                    playerId: String?) -> GameEnvironment
//    func createRemoteGameEnvironment(gameId: String,
//                                     playerId: String?,
//                                     state: StateProtocol,
//                                     users: [String: WUserInfo]) -> GameEnvironment
}

class GameBuilder: GameBuilderProtocol {
    
    private let preferences: UserPreferencesProtocol
    private let resourcesLoader: ResourcesLoaderProtocol
    
    init(preferences: UserPreferencesProtocol,
         resourcesLoader: ResourcesLoaderProtocol) {
        self.preferences = preferences
        self.resourcesLoader = resourcesLoader
    }
    
    func createGame(for playersCount: Int) -> StateProtocol {
        let cards = try! resourcesLoader.loadCards()
        let cardSet = try! resourcesLoader.loadDeck()
        let scenario = try! resourcesLoader.loadDefault()
        
        let setup = GSetup()
        let roles = setup.roles(for: playersCount)
        return setup.setupGame(roles: roles,
                               cards: cards,
                               cardSet: cardSet,
                               scenario: scenario,
                               preferredRole: preferences.preferredRole,
                               preferredFigure: preferences.preferredFigure)
    }
    
    func createLocalGameEnvironment(state: StateProtocol,
                                    playerId: String?) -> GameEnvironment {
        let abilities = try! resourcesLoader.loadAbilities()
        let scores = try! resourcesLoader.loadScores()
        
        let eventMatcher = EventMatcher()
        let database = GDatabase(state, matcher: eventMatcher)
        
        let playReqMatcher = PlayReqMatcher()
        let effectMatcher = EffectMatcher()
        let abilityMatcher = AbilityMatcher(abilities: abilities, effectMatcher: effectMatcher, playReqMatcher: playReqMatcher)
        let eventsQueue = GEventQueue()
        let timer = GTimer(delay: preferences.updateDelay, matcher: eventMatcher)
        let loop = GLoop(eventsQueue: eventsQueue, database: database, matcher: abilityMatcher, timer: timer)
        let engine = GEngine(loop: loop, database: database, matcher: abilityMatcher)
        
        let sheriff = state.players.values.first(where: { $0.role == .sheriff })!.identifier
        let agents: [AIAgentProtocol] = state.playOrder.filter { $0 != playerId }.map { player in
            let roleEstimator = RoleEstimator(sheriff: sheriff, abilityScores: scores)
            let roleStrategy = RoleStrategy()
            let moveEvaluator = MoveEvaluator(abilityScores: scores, roleEstimator: roleEstimator, roleStrategy: roleStrategy)
            let ai = GAI(moveEvaluator: moveEvaluator)
            return AIAgent(player: player, engine: engine, database: database, ai: ai, roleEstimator: roleEstimator)
        }
        
        agents.forEach { $0.observe() }
        
        return GameEnvironment(engine: engine,
                               database: database,
                               controlledId: playerId,
                               aiAgents: agents)
    }
    /*
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
 */
}
