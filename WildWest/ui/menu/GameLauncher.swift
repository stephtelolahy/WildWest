//
//  GameLauncher.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import RxSwift

class GameLauncher {
    
    private unowned let viewController: UIViewController
    
    private lazy var userPreferences = UserPreferences()
    
    private lazy var builder = GameEnvironmentBuilder()
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    private lazy var gameResources: GameResources = {
        let jsonReader = JsonReader(bundle: Bundle.main)
        let resources = GameResources(jsonReader: jsonReader)
        return resources
    }()
    
    private lazy var allCards: [CardProtocol] = gameResources.allCards
    
    private lazy var allFigures: [FigureProtocol] = gameResources.allFigures.filter { !$0.abilities.isEmpty }
    
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
        let state = builder.createGame(playersCount: userPreferences.playersCount,
                                       cards: allCards,
                                       figures: allFigures,
                                       preferredRole: userPreferences.playAsSheriff ? .sheriff : nil,
                                       preferredFigure: userPreferences.preferredFigure)
        
        let controlledId: String? = !userPreferences.simulationMode ? state.players.first?.identifier : nil
        
        let environment = builder.createLocalEnvironment(state: state,
                                                         controlledId: controlledId,
                                                         updateDelay: userPreferences.updateDelay)
        
        Navigator(viewController).toGame(environment: environment)
    }
    
    func startRemote() {
        /*
        let state = createGame()
        firebaseAdapter.createGame(state) { [weak self] result in
            switch result {
            case let .success(gameId):
                self?.joinRemoteGame(gameId)
                
            case let .error(error):
                self?.viewController.presentAlert(title: "Error", message: error.localizedDescription)
            }
        }
 */
    }
}
/*
private extension GameLauncher {
    
    func joinRemoteGame(_ id: String) {
        firebaseAdapter.getGame(id) { [weak self] result in
            switch result {
            case let .success(initialState):
                self?.setupRemoteGame(id, state: initialState)
                
            case let .error(error):
                self?.viewController.presentAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    func setupRemoteGame(_ id: String, state: GameStateProtocol) {
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
        
        Navigator(viewController).toGame(engine: engine,
                                         subjects: subjects,
                                         controlledPlayerId: controlledPlayerId,
                                         aiAgents: nil)
    }
}
*/
