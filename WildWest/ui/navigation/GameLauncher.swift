//
//  GameLauncher.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable force_cast

import UIKit
import RxSwift
import Firebase

class GameLauncher: Subscribable {
    
    func createLocalGame() -> GameEnvironment {
        let state = createGame()
        
        let controlledId: String? =
            !AppModules.shared.userPreferences.simulationMode ? state.players.first?.identifier : nil
        
        return createLocalEnvironment(state: state,
                                      controlledId: controlledId,
                                      updateDelay: AppModules.shared.userPreferences.updateDelay)
    }
    
    func createRemoteGame(gameId: String, playerId: String, completion: @escaping (GameEnvironment) -> Void) {
        sub(AppModules.shared.matchingDatabase.getGame(gameId).subscribe(onSuccess: { state in
            
            let environment = self.createRemoteEnvironment(gameId: gameId,
                                                           state: state,
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
}

private extension GameLauncher {
    
    func createGame() -> GameStateProtocol {
        let userPreferences = AppModules.shared.userPreferences
        let playersCount = userPreferences.playersCount
        let cards = AppModules.shared.gameResources.allCards
        let figures = AppModules.shared.gameResources.allFigures.filter { !$0.abilities.isEmpty }
        let preferredRole: Role? = userPreferences.playAsSheriff ? .sheriff : nil
        let preferredFigure = userPreferences.preferredFigure
        
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
                               aiAgents: nil)
    }
}
