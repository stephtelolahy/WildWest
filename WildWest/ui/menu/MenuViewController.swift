//
//  MenuViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import UIKit
import AVFoundation

class MenuViewController: UIViewController {
    
    @IBOutlet private weak var playersCountStepper: UIStepper!
    @IBOutlet private weak var playersCountLabel: UILabel!
    @IBOutlet private weak var playAsSheriffSwitch: UISwitch!
    @IBOutlet private weak var figureLabel: UILabel!
    @IBOutlet private weak var figureButton: UIButton!
    @IBOutlet private weak var roleLabel: UILabel!
    
    private var audioPlayer: AVAudioPlayer?
    
    private var allFigures: [FigureProtocol]!
    private var allCards: [CardProtocol]!
    private var allMatchers: [MoveMatcherProtocol]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        figureButton.addBrownRoundedBorder()
        
        let jsonReader = JsonReader(bundle: Bundle.main)
        let config = GameConfiguration(jsonReader: jsonReader)
        
        allFigures = config.allFigures.filter { !$0.abilities.isEmpty }
        allCards = config.allCards
        allMatchers = config.moveMatchers
        
        playersCountStepper.value = Double(UserPreferences.shared.playersCount)
        updatePlayersLabel()
        
        updateFigureImage()
        
        playAsSheriffSwitch.isOn = UserPreferences.shared.playAsSheriff
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
        createGame()
    }
    
    @IBAction private func stepperValueChanged(_ sender: Any) {
        UserPreferences.shared.playersCount = Int(playersCountStepper.value)
        updatePlayersLabel()
    }
    
    @IBAction private func figureButtonTapped(_ sender: Any) {
        showFigureSelector(figures: allFigures.map { $0.name }) { [weak self] figure in
            UserPreferences.shared.preferredFigure = figure?.rawValue ?? ""
            self?.updateFigureImage()
        }
    }
    
    @IBAction private func playAsSheriffValueChanged(_ sender: Any) {
        UserPreferences.shared.playAsSheriff = playAsSheriffSwitch.isOn
    }
    
    @IBAction private func contactButtonTapped(_ sender: Any) {
        let email = "stephano.telolahy@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
            openUrl(url)
        }
    }
    
    @IBAction private func logoButtonTapped(_ sender: Any) {
        let rulesUrl = "http://www.dvgiochi.net/bang/bang_rules.pdf"
        if let url = URL(string: rulesUrl) {
            openUrl(url)
        }
    }
}

private extension MenuViewController {
    
    var preferredFigure: FigureName? {
        allFigures.map { $0.name }.first(where: { $0.rawValue == UserPreferences.shared.preferredFigure })
    }
    
    var playersCount: Int {
        UserPreferences.shared.playersCount
    }
    
    var playAsSheriff: Bool {
        UserPreferences.shared.playAsSheriff
    }
    
    func updatePlayersLabel() {
        playersCountLabel.text = "\(playersCount) players"
    }
    
    func updateFigureImage() {
        if let figure = allFigures.first(where: { $0.name == preferredFigure }) {
            figureButton.setImage(UIImage(named: figure.imageName), for: .normal)
            figureLabel.text = "Play as \(figure.name.rawValue)"
        } else {
            figureButton.setImage(#imageLiteral(resourceName: "01_random"), for: .normal)
            figureLabel.text = "Play as random"
        }
    }
    
    func createGame() {
        
        let gameSetup = GameSetup()
        
        var roles = gameSetup.roles(for: playersCount).shuffled()
        if playAsSheriff {
            roles = roles.starting(with: .sheriff)
        }
        
        var figures = allFigures.shuffled()
        if let preferredFigure = self.preferredFigure {
            figures = figures.starting(with: preferredFigure)
        }
        
        let state = gameSetup.setupGame(roles: roles,
                                        figures: figures,
                                        cards: allCards.shuffled())
        let database = MemoryCachedDataBase(state: state)
        
        let engine = GameEngine(database: database,
                                moveMatchers: allMatchers,
                                updateExecutor: GameUpdateExecutor(),
                                eventQueue: DelayedEventQueue(delay: UserPreferences.shared.updateDelay))
        
        let controlledPlayerId: String? = UserPreferences.shared.simulationMode ? nil : state.players.first?.identifier
        let aiPlayers = database.state.players.filter { $0.identifier != controlledPlayerId }
        let aiAgents = aiPlayers.map { AIPlayerAgent(playerId: $0.identifier,
                                                     ai: RandomAIWithRole(),
                                                     engine: engine)
        }
        
        presentGame(engine: engine, controlledPlayerId: controlledPlayerId, aiAgents: aiAgents)
    }
    
    func playThemeMusic() {
        guard UserPreferences.shared.enableSound else {
            return
        }
        
        let musicFile = "Cowboy_Theme-Pavak-1711860633.mp3"
        guard let path = Bundle.main.path(forResource: musicFile, ofType: nil) else {
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

private extension Array where Element: Equatable {
    func starting(with element: Element) -> [Element] {
        var array = self
        while array.first != element {
            array = array.shuffled()
        }
        return array
    }
}

private extension UIViewController {
    func openUrl(_ url: URL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
