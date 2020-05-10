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
        let environment = builder.createLocalEnvironment(state: state,
                                                         controlledId: controlledId,
                                                         updateDelay: userPreferences.updateDelay)
        Navigator(viewController).toGame(environment: environment)
    }
    
    func startRemote() {
        let gameId = "live"
        getOrCreateRemoteGame(id: gameId) { state in
            
            let choices = state.allPlayers.map { "\($0.identifier) \($0.role == .sheriff ? "*" : "")" }
            self.viewController.select(title: "Choose player", choices: choices) { index in
                
                let controlledId = state.allPlayers[index].identifier
                let environment = self.builder.createRemoteEnvironment(gameId: gameId,
                                                                       state: state,
                                                                       controlledId: controlledId,
                                                                       updateDelay: self.userPreferences.updateDelay,
                                                                       firebaseMapper: self.firebaseMapper)
                
                Navigator(self.viewController).toGame(environment: environment)
            }
        }
    }
}

private extension GameLauncher {
    
    func createGame() -> GameStateProtocol {
        let playersCount = userPreferences.playersCount
        let cards = allCards
        let figures = allFigures
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
}
