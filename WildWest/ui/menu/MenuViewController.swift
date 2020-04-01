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
    
    private var audioPlayer: AVAudioPlayer?
    
    private var allFigures: [FigureProtocol] = []
    private var allCards: [CardProtocol] = []
    private var allMatchers: [MoveMatcherProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playersCountStepper.value = 5
        updatePlayersLabel()
        
        let jsonReader = JsonReader(bundle: Bundle.main)
        let config = GameConfiguration(jsonReader: jsonReader)
        allFigures = config.allFigures
        allCards = config.allCards
        allMatchers = config.moveMatchers
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playThemeMusic()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopMusic()
    }
    
    @IBAction private func playButtonTapped(_ sender: Any) {
        showFigureSelector(figures: allFigures.map { $0.name }) { [weak self] preferredFigure in
            self?.startGame(preferredFigure: preferredFigure)
        }
    }
    
    @IBAction private func stepperValueChanged(_ sender: Any) {
        updatePlayersLabel()
    }
}

private extension MenuViewController {
    
    var playersCount: Int {
        Int(playersCountStepper.value)
    }
    
    func updatePlayersLabel() {
        playersCountLabel.text = "\(playersCount) players"
    }
    
    func startGame(preferredFigure: FigureName?) {
        
        let gameSetup = GameSetup()
        
        var roles = gameSetup.roles(for: playersCount).shuffled()
        if playAsSheriffSwitch.isOn {
            roles = roles.starting(with: .sheriff)
        }
        
        var figures = allFigures.shuffled()
        if let preferredFigure = preferredFigure {
            figures = figures.starting(with: preferredFigure)
        }
        
        let state = gameSetup.setupGame(roles: roles,
                                        figures: figures,
                                        cards: allCards.shuffled())
        let database = MemoryCachedDataBase(state: state)
        
        let engine = GameEngine(database: database,
                                moveMatchers: allMatchers,
                                updateExecutor: GameUpdateExecutor(),
                                updateDelay: 0.5)
        
        let controlledPlayerId = state.players.first?.identifier
        let aiPlayers = database.state.players.filter { $0.identifier != controlledPlayerId }
        let aiAgents = aiPlayers.map { AIPlayerAgent(playerId: $0.identifier,
                                                     ai: RandomAIWithRole(),
                                                     engine: engine,
                                                     delay: 0.5)
        }
        
        presentGame(engine: engine, controlledPlayerId: controlledPlayerId, aiAgents: aiAgents)
    }
    
    func playThemeMusic() {
        guard let path = Bundle.main.path(forResource: "Cowboy_Theme-Pavak-1711860633.mp3", ofType: nil) else {
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            fatalError("couldn't load file") 
        }
    }
    
    func stopMusic() {
        audioPlayer?.stop()
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
    
    func showFigureSelector(figures: [FigureName], completion: @escaping ((FigureName?) -> Void)) {
        let alertController = UIAlertController(title: "Choose figure",
                                                message: nil,
                                                preferredStyle: .alert)
        
        figures.forEach { figure in
            alertController.addAction(UIAlertAction(title: figure.rawValue,
                                                    style: .default,
                                                    handler: { _ in
                                                        guard let index = figures.firstIndex(of: figure) else {
                                                            return
                                                        }
                                                        completion(figures[index])
            }))
        }
        
        alertController.addAction(UIAlertAction(title: "Random",
                                                style: .cancel,
                                                handler: { _ in
                                                    completion(nil)
        }))
        
        present(alertController, animated: true)
    }
}

private extension Array where Element == FigureProtocol {
    func starting(with name: FigureName) -> [FigureProtocol] {
        filter { $0.name == name } + filter { $0.name != name }
    }
}

private extension Array where Element == Role {
    func starting(with role: Role) -> [Role] {
        var array = self
        while array.first != role {
            array = array.shuffled()
        }
        return array
    }
}
