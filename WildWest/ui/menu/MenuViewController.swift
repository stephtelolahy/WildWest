//
//  MenuViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable force_cast

import UIKit
import AVFoundation
import SafariServices
import RxSwift

class MenuViewController: UIViewController, Subscribable {
    
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
        
        let jsonReader = JsonReader(bundle: Bundle.main)
        let resources = GameResources(jsonReader: jsonReader)
        
        allFigures = resources.allFigures.filter { !$0.abilities.isEmpty }
        
        if UserPreferences.shared.allAbilitiesMode {
            var allAbilities: [AbilityName: Bool] = [:]
            AbilityName.allCases.forEach { allAbilities[$0] = true }
            allFigures = allFigures.map { Figure(name: $0.name,
                                                 bullets: $0.bullets,
                                                 imageName: $0.imageName,
                                                 description: $0.description,
                                                 abilities: allAbilities)
            }
        }
        
        allCards = resources.allCards
        
        let rules = GameRules()
        allMatchers = rules.moveMatchers
        
        figureButton.addBrownRoundedBorder()
        
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
        startLocalGame()
    }
    
    @IBAction private func onlineButtonTapped(_ sender: Any) {
        startRemoteGame()
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
            if #available(iOS 11.0, *) {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                let safariViewController = SFSafariViewController(url: url, configuration: config)
                present(safariViewController, animated: true)
            } else {
                openUrl(url)
            }
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
    
    func startLocalGame() {
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
                                moveMatchers: allMatchers,
                                updateExecutor: GameUpdateExecutor(),
                                subjects: subjects)
        
        let controlledPlayerId: String? = UserPreferences.shared.simulationMode ? nil : state.players.first?.identifier
        let aiPlayers = state.players.filter { $0.identifier != controlledPlayerId }
        let aiAgents = aiPlayers.map { AIPlayerAgent(playerId: $0.identifier,
                                                     ai: RandomAIWithRole(),
                                                     engine: engine)
        }
        
        presentGame(engine: engine, controlledPlayerId: controlledPlayerId, aiAgents: aiAgents)
    }
    
    /////////////// FIREBASE ///////////////
    
    func startRemoteGame() {
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
    
    /////////////// FIREBASE ///////////////
    
    func createGame() -> GameStateProtocol {
        let gameSetup = GameSetup()
        
        var roles = gameSetup.roles(for: playersCount).shuffled()
        if playAsSheriff {
            roles = roles.starting(with: .sheriff)
        }
        
        var figures = allFigures.shuffled()
        if let preferredFigure = self.preferredFigure {
            figures = figures.starting(with: preferredFigure)
        }
        
        return gameSetup.setupGame(roles: roles,
                                   figures: figures,
                                   cards: allCards.shuffled())
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
    
    func presentGame(engine: GameEngineProtocol, controlledPlayerId: String?, aiAgents: [AIPlayerAgent]) {
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
