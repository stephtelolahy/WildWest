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
    
    private let navigator: Navigator
    
    init(navigator: Navigator) {
        self.navigator = navigator
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
    
    func startLocal() {
        
        let rules = GameRules()
        
        let state = createGame()
        
        let stateSubject: BehaviorSubject<GameStateProtocol> = BehaviorSubject(value: state)
        
        let database = MemoryCachedDataBase(mutableState: state as! GameState,
                                            stateSubject: stateSubject)
        
        let subjects = GameSubjects(stateSubject: stateSubject,
                                    executedMoveSubject: PublishSubject(),
                                    executedUpdateSubject: PublishSubject(),
                                    validMovesSubject: PublishSubject())
        
        let engine = GameEngine(delay: UserPreferences.shared.updateDelay,
                                database: database,
                                moveMatchers: rules.moveMatchers,
                                updateExecutor: GameUpdateExecutor(),
                                subjects: subjects)
        
        let controlledPlayerId: String? = UserPreferences.shared.simulationMode ? nil : state.players.first?.identifier
        let aiPlayers = state.players.filter { $0.identifier != controlledPlayerId }
        let aiAgents = aiPlayers.map { AIPlayerAgent(playerId: $0.identifier,
                                                     ai: RandomAIWithRole(),
                                                     engine: engine)
        }
        
        navigator.toGame(engine: engine, controlledPlayerId: controlledPlayerId, aiAgents: aiAgents)
    }
    
    func startRemote() {
        let state = createGame()
        
        let firebaseProvider = FirebaseProvider(dtoEncoder: DtoEncoder(),
                                                dtoDecoder: DtoDecoder(allCards: allCards),
                                                dictionaryEncoder: DictionaryEncoder(),
                                                dictionaryDecoder: DictionaryDecoder())
        
        let key = firebaseProvider.createGame(state)
        print("Created remote game with id: \(key)")
        
        joinRemoteGame(id: key, firebaseProvider: firebaseProvider)
    }
    
    func joinRemoteGame(id: String, firebaseProvider: FirebaseProvider) {
        
        firebaseProvider.getGame(id) { initialState in
            
            // create remote database now
            print(String(describing: initialState))
        }
    }
}

private extension GameLauncher {
    
    func createGame() -> GameStateProtocol {
        let gameSetup = GameSetup()
        
        let roles = gameSetup.roles(for: UserPreferences.shared.playersCount)
            .shuffled()
            .starting(withSheriff: UserPreferences.shared.playAsSheriff)
        
        let figures = allFigures
            .shuffled()
            .starting(with: UserPreferences.shared.preferredFigure)
        
        return gameSetup.setupGame(roles: roles,
                                   figures: figures,
                                   cards: allCards.shuffled())
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

private extension Array where Element == Role {
    func starting(withSheriff: Bool) -> [Role] {
        var roles = self
        while (roles.first == .sheriff) != withSheriff {
            roles = roles.shuffled()
        }
        
        return roles
    }
}
