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
    private let durationMatcher: DurationMatcherProtocol
    private let database: UserDatabaseProtocol
    
    init(preferences: UserPreferencesProtocol,
         resourcesLoader: ResourcesLoaderProtocol,
         durationMatcher: DurationMatcherProtocol,
         database: UserDatabaseProtocol) {
        self.preferences = preferences
        self.resourcesLoader = resourcesLoader
        self.durationMatcher = durationMatcher
        self.database = database
    }
    
    func createGame(for playersCount: Int) -> StateProtocol {
        let cards = resourcesLoader.loadCards()
        let cardSet = resourcesLoader.loadDeck()
        let defaults = resourcesLoader.loadDefaults()
        
        let setup = GSetup()
        let roles = setup.roles(for: playersCount)
        return setup.setupGame(roles: roles,
                               cards: cards,
                               cardSet: cardSet,
                               defaults: defaults,
                               preferredRole: preferences.preferredRole,
                               preferredFigure: preferences.preferredFigure)
    }
    
    func createLocalGameEnvironment(state: StateProtocol,
                                    playerId: String?) -> GameEnvironment {
        
        let databaseUpdater = GDatabaseUpdater()
        let database = GDatabase(state, updater: databaseUpdater)
        
        let playReqMatcher = PlayReqMatcher()
        let effectMatcher = EffectMatcher()
        let abilities = resourcesLoader.loadAbilities()
        let abilityMatcher = AbilityMatcher(abilities: abilities, effectMatcher: effectMatcher, playReqMatcher: playReqMatcher)
        let eventsQueue = GEventQueue()
        let timer = GTimer(matcher: durationMatcher)
        let loop = GLoop(eventsQueue: eventsQueue, database: database, matcher: abilityMatcher, timer: timer)
        let engine = GEngine(loop: loop)
        
        let sheriff = state.players.values.first(where: { $0.role == .sheriff })!.identifier
        let agents: [AIAgentProtocol] = state.playOrder.filter { $0 != playerId }.map { player in
            let abilityEvaluator = AbilityEvaluator()
            let roleEstimator = RoleEstimator(sheriff: sheriff, abilityEvaluator: abilityEvaluator)
            let roleStrategy = RoleStrategy()
            let moveEvaluator = MoveEvaluator(abilityEvaluator: abilityEvaluator, roleEstimator: roleEstimator, roleStrategy: roleStrategy)
            let ai = GAI(moveEvaluator: moveEvaluator)
            return AIAgent(player: player, engine: engine, ai: ai, roleEstimator: roleEstimator)
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
        
        let playReqMatcher = PlayReqMatcher()
        let effectMatcher = EffectMatcher()
        let abilities = resourcesLoader.loadAbilities()
        let abilityMatcher = AbilityMatcher(abilities: abilities, effectMatcher: effectMatcher, playReqMatcher: playReqMatcher)
        let eventsQueue = GEventQueue()
        let timer = GTimer(matcher: durationMatcher)
        let loop = GLoop(eventsQueue: eventsQueue, database: gameDatabase, matcher: abilityMatcher, timer: timer)
        let engine = GEngine(loop: loop)
        
        return GameEnvironment(engine: engine,
                               database: gameDatabase,
                               controlledId: playerId,
                               users: users)
    }
}
