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
    
    private lazy var firebaseAdapter: FirebaseAdapterProtocol = FirebaseAdapter(mapper: firebaseMapper)
    
    func startLocal() {
        let state = createGame()
        let controlledId: String? = !userPreferences.simulationMode ? state.players.first?.identifier : nil
        joinLocalGame(state: state, as: controlledId)
    }
    
    func startRemote() {
        let gameId = "live"
        getOrCreateRemoteGame(id: gameId) { [weak self] state in
            let choices = state.allPlayers.map { "\($0.identifier) \($0.role == .sheriff ? "*" : "")" }
            self?.viewController.select(title: "Choose player", choices: choices) { index in
                self?.joinRemoteGame(id: gameId, state: state, as: state.allPlayers[index].identifier)
            }
        }
    }
}

private extension GameLauncher {
    
    func createGame() -> GameStateProtocol {
        builder.createGame(playersCount: userPreferences.playersCount,
                           cards: allCards,
                           figures: allFigures,
                           preferredRole: userPreferences.playAsSheriff ? .sheriff : nil,
                           preferredFigure: userPreferences.preferredFigure)
    }
    
    func joinLocalGame(state: GameStateProtocol, as controlledId: String?) {
        let environment = builder.createLocalEnvironment(state: state,
                                                         controlledId: controlledId,
                                                         updateDelay: userPreferences.updateDelay)
        
        Navigator(viewController).toGame(environment: environment)
    }
    
    func getOrCreateRemoteGame(id: String, completion: @escaping ((GameStateProtocol) -> Void)) {
        firebaseAdapter.getPendingGame(id) { result in
            switch result {
            case let .success(state):
                completion(state)
                
            case .error:
                let state = self.createGame()
                self.firebaseAdapter.createGame(id: id, state: state) { [weak self] result in
                    switch result {
                    case .success:
                        completion(state)
                        
                    case let .error(error):
                        self?.viewController.presentAlert(title: "Error", message: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func joinRemoteGame(id: String, state: GameStateProtocol, as controlledId: String?) {
        let environment = builder.createRemoteEnvironment(gameId: id,
                                                          state: state,
                                                          controlledId: controlledId,
                                                          updateDelay: userPreferences.updateDelay,
                                                          firebaseMapper: firebaseMapper)
        
        Navigator(viewController).toGame(environment: environment)
    }
}
