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

class GameBuilder: Subscribable {
    
    func createLocalGameEnvironment() -> GameEnvironment {
        let userPreferences = AppModules.shared.userPreferences
        let state = createGame(for: userPreferences.playersCount,
                               preferredFigure: userPreferences.preferredFigure,
                               preferredRole: userPreferences.playAsSheriff ? .sheriff : nil)
        
        let controlledId = state.players.first?.identifier
        
        return createLocalEnvironment(state: state,
                                      controlledId: controlledId,
                                      updateDelay: userPreferences.updateDelay)
    }
    
    func createRemoteGameEnvironment(gameId: String,
                                     playerId: String,
                                     completion: @escaping (GameEnvironment) -> Void) {
        
        let request: Single<(GameStateProtocol, [String: WUserInfo])> =
            AppModules.shared.matchingDatabase.getGame(gameId)
                .flatMap {  state in
                    AppModules.shared.matchingDatabase.getGameUsers(gameId: gameId)
                        .map { users in (state, users) }
                }
        
        sub(request.subscribe(onSuccess: { data in
            let (state, users) = data
            let environment = self.createRemoteEnvironment(gameId: gameId,
                                                           state: state,
                                                           users: users,
                                                           controlledId: playerId,
                                                           updateDelay: AppModules.shared.userPreferences.updateDelay,
                                                           firebaseMapper: AppModules.shared.firebaseMapper)
            
            // wait until executedMove and executedUpdate PublishSubjects emit lastest values
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                completion(environment)
            }
            
        }, onError: { error in
            fatalError(error.localizedDescription)
        }))
    }
    
    func createGame(for playersCount: Int,
                    preferredFigure: String? = nil,
                    preferredRole: Role? = nil) -> GameStateProtocol {
        let cards = AppModules.shared.gameResources.allCards
        let figures = AppModules.shared.gameResources.allFigures
        
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
}

private extension GameBuilder {
    
    func createLocalEnvironment(state: GameStateProtocol,
                                controlledId: String?,
                                updateDelay: TimeInterval) -> GameEnvironment {
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
        
        let engine = GameEngine(delay: updateDelay,
                                database: database,
                                moveMatchers: GameRules().moveMatchers)
        
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
    
    func createRemoteEnvironment(gameId: String,
                                 state: GameStateProtocol,
                                 users: [String: WUserInfo],
                                 controlledId: String?,
                                 updateDelay: TimeInterval,
                                 firebaseMapper: FirebaseMapperProtocol) -> GameEnvironment {
        let stateSubject: BehaviorSubject<GameStateProtocol> = BehaviorSubject(value: state)
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
        
        let engine = GameEngine(delay: updateDelay,
                                database: database,
                                moveMatchers: GameRules().moveMatchers)
        
        return GameEnvironment(engine: engine,
                               subjects: subjects,
                               controlledId: controlledId,
                               aiAgents: nil,
                               gameUsers: users)
    }
}
