//
//  GameBuilder.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import RxSwift
import Firebase
import WildWestEngine

protocol GameBuilderProtocol {
    func createGame(for playersCount: Int) -> StateProtocol
    func createLocalGameEnvironment(state: StateProtocol,
                                    playerId: String?) -> GameEnvironment
    func createRemoteGameEnvironment(state: StateProtocol,
                                     playerId: String?,
                                     gameId: String,
                                     users: [String: UserInfo]) -> GameEnvironment
}

class GameBuilder: GameBuilderProtocol {
    
    private let preferences: UserPreferencesProtocol
    private let resourcesLoader: ResourcesLoaderProtocol
    private let durationMatcher: EventDurationProtocol
    private let database: UserDatabaseProtocol
    private let rules: GameRulesProtocol
    
    init(preferences: UserPreferencesProtocol,
         resourcesLoader: ResourcesLoaderProtocol,
         durationMatcher: EventDurationProtocol,
         database: UserDatabaseProtocol,
         rules: GameRulesProtocol) {
        self.preferences = preferences
        self.resourcesLoader = resourcesLoader
        self.durationMatcher = durationMatcher
        self.database = database
        self.rules = rules
    }
    
    func createGame(for playersCount: Int) -> StateProtocol {
        let cards = resourcesLoader.loadCards()
        let cardSet = resourcesLoader.loadDeck()
        
        let setup = GSetup()
        let roles = setup.roles(for: playersCount)
        return setup.setupGame(roles: roles,
                               cards: cards,
                               cardSet: cardSet,
                               preferredRole: preferences.preferredRole,
                               preferredFigure: preferences.preferredFigure)
    }
    
    func createLocalGameEnvironment(state: StateProtocol,
                                    playerId: String?) -> GameEnvironment {
        
        let database = GDatabase(state, updater: GDatabaseUpdater())
        let timer = GTimer(matcher: durationMatcher)
        let engine = GEngine(queue: GEventQueue(), database: database, rules: rules, timer: timer)
        
        let sheriff = state.players.values.first(where: { $0.role == .sheriff })!.identifier
        let agents: [AIAgentProtocol] = state.playOrder.filter { $0 != playerId }.map { player in
            let abilityEvaluator = AbilityEvaluator()
            let roleEstimator = RoleEstimator(sheriff: sheriff, abilityEvaluator: abilityEvaluator)
            let roleStrategy = RoleStrategy()
            let moveEvaluator = MoveEvaluator(abilityEvaluator: abilityEvaluator, roleEstimator: roleEstimator, roleStrategy: roleStrategy)
            let ai = RandomWithRoleAi(moveEvaluator: moveEvaluator)
            return AIAgent(player: player, engine: engine, ai: ai)
        }
        
        agents.forEach { $0.observe(database) }
        
        return GameEnvironment(engine: engine,
                               database: database,
                               controlledId: playerId,
                               aiAgents: agents)
    }
    
    func createRemoteGameEnvironment(state: StateProtocol,
                                     playerId: String?,
                                     gameId: String,
                                     users: [String: UserInfo]) -> GameEnvironment {
        let gameDatabase = database.createGameDatabase(gameId, state: state)
        let timer = GTimer(matcher: durationMatcher)
        let engine = GEngine(queue: GEventQueue(), database: gameDatabase, rules: rules, timer: timer)
        
        return GameEnvironment(engine: engine,
                               database: gameDatabase,
                               controlledId: playerId,
                               users: users)
    }
}
