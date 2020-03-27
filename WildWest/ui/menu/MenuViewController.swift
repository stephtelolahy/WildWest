//
//  MenuViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import AVFoundation

class MenuViewController: UIViewController {
    
    @IBOutlet private weak var playersCountStepper: UIStepper!
    @IBOutlet private weak var playersCountLabel: UILabel!
    @IBOutlet private weak var playAsSheriffSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playersCountStepper.value = 5
        updatePlayersLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playThemeMusic()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopMusic()
    }
    
    private var audioPlayer: AVAudioPlayer?
    
    private func playThemeMusic() {
        guard let path = Bundle.main.path(forResource: "Cowboy_Theme-Pavak-1711860633.mp3", ofType: nil) else {
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    private func stopMusic() {
        audioPlayer?.stop()
    }
    
    @IBAction private func playButtonTapped(_ sender: Any) {
        startGame()
    }
    
    @IBAction private func stepperValueChanged(_ sender: Any) {
        updatePlayersLabel()
    }
    
    private func updatePlayersLabel() {
        playersCountLabel.text = "\(playersCount) players"
    }
    
    private var playersCount: Int {
        Int(playersCountStepper.value)
    }
    
    // swiftlint:disable function_body_length
    private func startGame() {
        
        let jsonReader = JsonReader(bundle: Bundle.main)
        let config = GameConfiguration(jsonReader: jsonReader)
        let figures = config.allFigures
        let cards = config.allCards
        
        let gameSetup = GameSetup()
        let roles = gameSetup.roles(for: playersCount)
        let state = gameSetup.setupGame(roles: roles.shuffled(),
                                        figures: figures.shuffled(),
                                        cards: cards.shuffled())
        let database = MemoryCachedDataBase(state: state)
        
        let engine = GameEngine(database: database,
                                validMoveMatchers: config.validMoveMatchers,
                                autoPlayMoveMatchers: config.autoPlayMoveMatchers,
                                effectMatchers: config.effectMatchers,
                                moveExecutors: config.moveExectors,
                                updateExecutor: GameUpdateExecutor(),
                                updateDelay: 1.0)
        
        var controlledPlayerId: String?
        if playAsSheriffSwitch.isOn {
            controlledPlayerId = state.players.first(where: { $0.role == .sheriff })?.identifier
        } else {
            controlledPlayerId = state.players.first(where: { $0.role != .sheriff })?.identifier
        }
        
        let aiPlayers = database.state.players.filter { $0.identifier != controlledPlayerId }
        
        let aiAgents = aiPlayers.map { AIPlayerAgent(playerId: $0.identifier,
                                                     ai: RandomAIWithRole(),
                                                     engine: engine,
                                                     delay: 0.5)
        }
        
        presentGame(engine: engine, controlledPlayerId: controlledPlayerId, aiAgents: aiAgents)
    }
}

private extension UIViewController {
    func presentGame(engine: GameEngine, controlledPlayerId: String?, aiAgents: [AIPlayerAgent]) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let gameViewController =
            storyboard.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else {
                return
        }
        
        gameViewController.engine = engine
        gameViewController.controlledPlayerId = controlledPlayerId
        gameViewController.aiAgents = aiAgents
        present(gameViewController, animated: true)
    }
}
