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

class GameLauncher {
    
    private unowned let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    private lazy var gameResources: GameResources = {
        let jsonReader = JsonReader(bundle: Bundle.main)
        let resources = GameResources(jsonReader: jsonReader)
        return resources
    }()
    
    private lazy var allCards: [CardProtocol] = {
        gameResources.allCards
    }()
    
    private lazy var allFigures: [FigureProtocol] = {
        var figures = gameResources.allFigures
            .filter { !$0.abilities.isEmpty }
        
        if UserPreferences.shared.allAbilitiesMode {
            var allAbilities: [AbilityName: Bool] = [:]
            AbilityName.allCases.forEach { allAbilities[$0] = true }
            figures = figures.map { Figure(name: $0.name,
                                           bullets: $0.bullets,
                                           imageName: $0.imageName,
                                           description: $0.description,
                                           abilities: allAbilities)
            }
        }
        
        return figures
    }()
    
    private lazy var firebaseMapper: FirebaseMapperProtocol = {
        FirebaseMapper(dtoEncoder: DtoEncoder(keyGenerator: FirebaseKeyGenerator()),
                       dtoDecoder: DtoDecoder(allCards: allCards),
                       dictionaryEncoder: DictionaryEncoder(),
                       dictionaryDecoder: DictionaryDecoder())
    }()
    
    private lazy var firebaseAdapter: FirebaseAdapterProtocol = {
        FirebaseAdapter(mapper: firebaseMapper, keyGenerator: FirebaseKeyGenerator())
    }()
    
    func startLocal() {
        let state = createGame()
        
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
        
        Navigator(viewController).toGame(engine: engine,
                                         subjects: subjects,
                                         controlledPlayerId: controlledPlayerId,
                                         aiAgents: aiAgents)
    }
    
    func startRemote() {
        let state = createGame()
        firebaseAdapter.createGame(state) { [weak self] result in
            switch result {
            case let .success(gameId):
                self?.joinRemoteGame(gameId)
                
            case let .error(error):
                self?.viewController.presentAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    func joinRemoteGame(_ id: String) {
        firebaseAdapter.getGame(id) { [weak self] result in
            switch result {
            case let .success(initialState):
                self?.openRemoteGame(id, state: initialState)
                
            case let .error(error):
                self?.viewController.presentAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
}

private extension GameLauncher {
    
    func createGame() -> GameStateProtocol {
        let gameSetup = GameSetup()
        
        var roles = gameSetup.roles(for: UserPreferences.shared.playersCount)
            .shuffled()
        
        if UserPreferences.shared.playAsSheriff {
            roles = roles.starting(with: .sheriff)
        }
        
        let figures = allFigures
            .shuffled()
            .starting(with: UserPreferences.shared.preferredFigure)
        
        return gameSetup.setupGame(roles: roles,
                                   figures: figures,
                                   cards: allCards.shuffled())
    }
    
    func openRemoteGame(_ id: String, state: GameStateProtocol) {
        let stateSubject: BehaviorSubject<GameStateProtocol> = BehaviorSubject(value: state)
        
        let stateAdapter = FirebaseStateAdapter(gameId: id, mapper: firebaseMapper)
        let gameAdapter = FirebaseGameAdapter(gameId: id, mapper: firebaseMapper)
        
        let executedMoveSubject = PublishSubject<GameMove>()
        let executedUpdateSubject = PublishSubject<GameUpdate>()
        let validMovesSubject = PublishSubject<[GameMove]>()
        
        let database = RemoteDatabase(stateAdapter: stateAdapter,
                                      gameAdapter: gameAdapter,
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
        
        Navigator(viewController).toGame(engine: engine,
                                         subjects: subjects,
                                         controlledPlayerId: controlledPlayerId,
                                         aiAgents: aiAgents)
    }
}

private extension Array where Element == FigureProtocol {
    func starting(with name: String) -> [FigureProtocol] {
        guard contains(where: { $0.name.rawValue == name }) else {
            return self
        }
        
        return filter { $0.name.rawValue == name } + filter { $0.name.rawValue != name }
    }
}
