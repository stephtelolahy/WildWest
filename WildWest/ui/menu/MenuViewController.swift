//
//  MenuViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBAction private func playButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "New Game",
                                                message: nil,
                                                preferredStyle: .alert)
        
        Array(4...7).forEach { playersCount in
            let title = "\(playersCount) players"
            alertController.addAction(UIAlertAction(title: title,
                                                    style: .default,
                                                    handler: { [weak self] _ in
                                                        self?.startGame(for: playersCount)
            }))
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))
        
        present(alertController, animated: true)
    }
    
    // swiftlint:disable function_body_length
    private func startGame(for playersCount: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let gameViewController =
            storyboard.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else {
                return
        }
        
        let jsonReader = JsonReader(bundle: Bundle.main)
        let config = GameConfiguration(jsonReader: jsonReader)
        let figures = config.allFigures
        let cards = config.allCards
        
        let gameSetup = GameSetup()
        let roles = gameSetup.roles(for: playersCount)
        let state = gameSetup.setupGame(roles: roles.shuffled(),
                                        figures: figures.shuffled(),
                                        cards: cards.shuffled())
        
        guard let database = state as? GameDatabaseProtocol else {
            fatalError("Invalid database")
        }
        
        let engine = GameEngine(database: database,
                                validMoveMatchers: config.validMoveMatchers,
                                autoPlayMoveMatchers: config.autoPlayMoveMatchers,
                                effectMatchers: config.effectMatchers,
                                moveExecutors: config.moveExectors,
                                updateExecutors: config.updateExecutors)
        
        let controlledPlayerId = database.state.players.first(where: { $0.role == .sheriff })?.identifier
        
        let aiPlayers = database.state.players.filter { $0.identifier != controlledPlayerId }
        
        let aiAgents = aiPlayers.map { AIPlayerAgent(playerId: $0.identifier,
                                                     ai: RandomAIWithRole(),
                                                     engine: engine,
                                                     delay: 0.5)
        }
        
        gameViewController.engine = engine
        gameViewController.controlledPlayerId = controlledPlayerId
        gameViewController.aiAgents = aiAgents
        
        present(gameViewController, animated: true)
    }
    
}
