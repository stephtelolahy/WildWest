//
//  GameLauncher.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import RxSwift

class GameLauncher: Subscribable {
    
    private unowned let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    private lazy var userPreferences = AppModules.shared.userPreferences
    
    private lazy var builder = GameEnvironmentBuilder()
    
    private lazy var allFigures: [FigureProtocol] = {
        AppModules.shared.gameResources.allFigures.filter { !$0.abilities.isEmpty }
    }()
    
    func startLocal() {
        let state = createGame()
        let controlledId: String? = !userPreferences.simulationMode ? state.players.first?.identifier : nil
        let environment = builder.createLocalEnvironment(state: state,
                                                         controlledId: controlledId,
                                                         updateDelay: userPreferences.updateDelay)
        Navigator(viewController).toGame(environment: environment)
    }
    
    func startRemote() {
        sub(match().subscribe(onSuccess: { gameId, state in
            let choices = state.allPlayers.map { "\($0.identifier) \($0.role == .sheriff ? "*" : "")" }
            self.viewController.select(title: "Choose player", choices: choices) { index in
                let controlledId = state.allPlayers[index].identifier
                let environment = self.builder.createRemoteEnvironment(gameId: gameId,
                                                                       state: state,
                                                                       controlledId: controlledId,
                                                                       updateDelay: self.userPreferences.updateDelay,
                                                                       firebaseMapper: AppModules.shared.firebaseMapper)
                
                // wait until executedMove and executedUpdate PublishSubjects emit lastest values
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    Navigator(self.viewController).toGame(environment: environment)
                }
                
            }
        }, onError: { error in
            self.viewController.presentAlert(title: "Error", message: error.localizedDescription)
        }))
    }
    
    func match() -> Single<(String, GameStateProtocol)> {
        let gameId = "live"
        return AppModules.shared.matchingDatabase.getGame(gameId)
            .map({ (gameId, $0) })
            .catchError { _ in
                let state = self.createGame()
                return AppModules.shared.matchingDatabase.createGame(id: gameId, state: state)
                    .andThen(Single.just((gameId, state)))
            }
    }
}

private extension GameLauncher {
    
    func createGame() -> GameStateProtocol {
        let playersCount = userPreferences.playersCount
        let cards = AppModules.shared.gameResources.allCards
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
}
