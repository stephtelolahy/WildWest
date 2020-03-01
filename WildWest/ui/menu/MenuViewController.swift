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
            alertController.addAction(UIAlertAction(title: "\(playersCount) players",
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
    
    private func startGame(for playersCount: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let gameViewController =
            storyboard.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else {
                return
        }
        
        let provider = ResourcesProvider(jsonReader: JsonReader(bundle: Bundle.main))
        let gameLoader = GameLoader()
        let database = gameLoader.createGame(for: playersCount, provider: provider)
        let engine = GameEngine(database: database,
                                rules: gameLoader.classicRules(),
                                effectRules: gameLoader.effectRules())
        
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
