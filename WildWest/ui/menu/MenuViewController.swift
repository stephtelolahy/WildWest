//
//  MenuViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import RxSwift

class MenuViewController: UIViewController, Subscribable {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var playersCountStepper: UIStepper!
    @IBOutlet private weak var playersCountLabel: UILabel!
    @IBOutlet private weak var playAsSheriffSwitch: UISwitch!
    @IBOutlet private weak var figureLabel: UILabel!
    @IBOutlet private weak var figureButton: UIButton!
    @IBOutlet private weak var roleLabel: UILabel!
    
    // MARK: - Properties
    
    private lazy var allFigures: [FigureProtocol] = {
        let jsonReader = JsonReader(bundle: Bundle.main)
        let resources = GameResources(jsonReader: jsonReader)
        return resources.allFigures
    }()
    
    private lazy var musicPlayer = ThemeMusicPlayer()
    
    private lazy var figureSelector = FigureSelector(viewController: self)
    
    private lazy var navigator = Navigator(self)
    
    private lazy var launcher = GameLauncher(viewController: self)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        figureButton.addBrownRoundedBorder()
        playersCountStepper.value = Double(UserPreferences.shared.playersCount)
        updatePlayersLabel()
        updateFigureImage()
        playAsSheriffSwitch.isOn = UserPreferences.shared.playAsSheriff
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserPreferences.shared.enableSound {
            musicPlayer.play()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        musicPlayer.stop()
    }
    
    // MARK: - IBActions
    
    @IBAction private func playButtonTapped(_ sender: Any) {
        launcher.startLocal()
    }
    
    @IBAction private func onlineButtonTapped(_ sender: Any) {
        launcher.startRemote()
    }
    
    @IBAction private func stepperValueChanged(_ sender: Any) {
        UserPreferences.shared.playersCount = Int(playersCountStepper.value)
        updatePlayersLabel()
    }
    
    @IBAction private func figureButtonTapped(_ sender: Any) {
        figureSelector.selectFigure(within: allFigures.map { $0.name }) { [weak self] figure in
            UserPreferences.shared.preferredFigure = figure?.rawValue ?? ""
            self?.updateFigureImage()
        }
    }
    
    @IBAction private func playAsSheriffValueChanged(_ sender: Any) {
        UserPreferences.shared.playAsSheriff = playAsSheriffSwitch.isOn
    }
    
    @IBAction private func contactButtonTapped(_ sender: Any) {
        navigator.toContactUs()
    }
    
    @IBAction private func logoButtonTapped(_ sender: Any) {
        navigator.toRules()
    }
}

// MARK: - Updates

private extension MenuViewController {
    
    func updatePlayersLabel() {
        playersCountLabel.text = "\(UserPreferences.shared.playersCount) players"
    }
    
    func updateFigureImage() {
        if let figure = allFigures.first(where: { $0.name.rawValue == UserPreferences.shared.preferredFigure }) {
            figureButton.setImage(UIImage(named: figure.imageName), for: .normal)
            figureLabel.text = "Play as \(figure.name.rawValue)"
        } else {
            figureButton.setImage(#imageLiteral(resourceName: "01_random"), for: .normal)
            figureLabel.text = "Play as random"
        }
    }
}
