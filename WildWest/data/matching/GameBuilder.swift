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
    func createLocalGameEnvironment() -> GameEnvironment
    func createRemoteGameEnvironment(gameId: String,
                                     playerId: String,
                                     completion: @escaping (GameEnvironment) -> Void)
    func createGame(for playersCount: Int) -> GameStateProtocol
}

class GameBuilder: GameBuilderProtocol, Subscribable {
    
    private let preferences: UserPreferencesProtocol
    private let matchingDatabase: MatchingDatabaseProtocol
    private let gameResources: GameResourcesProtocol
    private let firebaseMapper: FirebaseMapperProtocol
    
    init(preferences: UserPreferencesProtocol,
         matchingDatabase: MatchingDatabaseProtocol,
         gameResources: GameResourcesProtocol,
         firebaseMapper: FirebaseMapperProtocol) {
        self.preferences = preferences
        self.matchingDatabase = matchingDatabase
        self.gameResources = gameResources
        self.firebaseMapper = firebaseMapper
    }
    
    func createLocalGameEnvironment() -> GameEnvironment {
        let state = createGame(for: preferences.playersCount)
        
        let controlledId = state.players.first?.identifier
        
        let stateSubject: BehaviorSubject<GameStateProtocol> = BehaviorSubject(value: state)
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
        
        let aiPlayers = state.players.filter { $0.identifier != controlledId }
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
                               controlledId: controlledId,
                               aiAgents: aiAgents)
    }
    
    func createRemoteGameEnvironment(gameId: String,
                                     playerId: String,
                                     completion: @escaping (GameEnvironment) -> Void) {
        
        let request: Single<(GameStateProtocol, [String: WUserInfo])> =
            matchingDatabase.getGame(gameId)
                .flatMap {  state in
                    self.matchingDatabase.getGameUsers(gameId: gameId)
                        .map { users in (state, users) }
                }
        
        sub(request.subscribe(onSuccess: { data in
            let (state, users) = data
            let stateSubject: BehaviorSubject<GameStateProtocol> = BehaviorSubject(value: state)
            let executedMoveSubject = PublishSubject<GameMove>()
            let executedUpdateSubject = PublishSubject<GameUpdate>()
            let validMovesSubject = BehaviorSubject<[GameMove]>(value: [])
            
            let gameRef = Database.database().reference().child("games/\(gameId)")
            let database = RemoteGameDatabase(gameRef: gameRef,
                                              mapper: self.firebaseMapper,
                                              stateSubject: stateSubject,
                                              executedMoveSubject: executedMoveSubject,
                                              executedUpdateSubject: executedUpdateSubject,
                                              validMovesSubject: validMovesSubject)
            
            let subjects = GameSubjects(stateSubject: stateSubject,
                                        executedMoveSubject: executedMoveSubject,
                                        executedUpdateSubject: executedUpdateSubject,
                                        validMovesSubject: validMovesSubject)
            
            let engine = GameEngine(delay: self.preferences.updateDelay,
                                    database: database,
                                    moveMatchers: GameRules().moveMatchers)
            
            let environment = GameEnvironment(engine: engine,
                                              subjects: subjects,
                                              controlledId: playerId,
                                              aiAgents: nil,
                                              gameUsers: users)
            
            // wait until executedMove and executedUpdate PublishSubjects emit lastest values
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                completion(environment)
            }
            
        }, onError: { error in
            fatalError(error.localizedDescription)
        }))
    }
    
    func createGame(for playersCount: Int) -> GameStateProtocol {
        let cards = gameResources.allCards
        let figures = gameResources.allFigures
        
        let gameSetup = GameSetup()
        
        let shuffledRoles = gameSetup.roles(for: playersCount)
            .shuffled()
            .starting(with: preferences.preferredRole)
        
        let shuffledFigures = figures
            .shuffled()
            .starting(where: { $0.name == preferences.preferredFigure })
        
        let shuffledCards = cards.shuffled()
        
        return gameSetup.setupGame(roles: shuffledRoles,
                                   figures: shuffledFigures,
                                   cards: shuffledCards)
    }
}
