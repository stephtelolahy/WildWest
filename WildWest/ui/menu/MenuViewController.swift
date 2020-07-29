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
    
    var onPlayLocal: (() -> Void)?
    var onPlayOnline: (() -> Void)?
    
    private lazy var userPreferences = AppModules.shared.userPreferences
    
    private lazy var allFigures: [FigureProtocol] = {
        let jsonReader = JsonReader(bundle: Bundle.main)
        let resources = GameResources(jsonReader: jsonReader)
        return resources.allFigures
    }()
    
    private lazy var musicPlayer: ThemeMusicPlayer? = {
        userPreferences.enableSound ? ThemeMusicPlayer() : nil
    }()
    
    private lazy var figureSelector = FigureSelector(viewController: self)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        figureButton.addBrownRoundedBorder()
        playersCountStepper.value = Double(userPreferences.playersCount)
        updatePlayersLabel()
        updateFigureImage()
        playAsSheriffSwitch.isOn = userPreferences.playAsSheriff
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        musicPlayer?.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        musicPlayer?.stop()
    }
    
    // MARK: - IBActions
    
    @IBAction private func playButtonTapped(_ sender: Any) {
        onPlayLocal?()
    }
    
    @IBAction private func onlineButtonTapped(_ sender: Any) {
        onPlayOnline?()
    }
    
    @IBAction private func stepperValueChanged(_ sender: Any) {
        userPreferences.playersCount = Int(playersCountStepper.value)
        updatePlayersLabel()
    }
    
    @IBAction private func figureButtonTapped(_ sender: Any) {
        figureSelector.selectFigure(within: allFigures.map { $0.name }) { [weak self] figure in
            self?.userPreferences.preferredFigure = figure?.rawValue ?? ""
            self?.updateFigureImage()
        }
    }
    
    @IBAction private func playAsSheriffValueChanged(_ sender: Any) {
        userPreferences.playAsSheriff = playAsSheriffSwitch.isOn
    }
    
    @IBAction private func contactButtonTapped(_ sender: Any) {
        Navigator(self).toContactUs()
    }
    
    @IBAction private func logoButtonTapped(_ sender: Any) {
        Navigator(self).toRules()
    }
}

// MARK: - Updates

private extension MenuViewController {
    
    func updatePlayersLabel() {
        playersCountLabel.text = "\(userPreferences.playersCount) players"
    }
    
    func updateFigureImage() {
        if let figure = allFigures.first(where: { $0.name.rawValue == userPreferences.preferredFigure }) {
            figureButton.setImage(UIImage(named: figure.imageName), for: .normal)
            figureLabel.text = "Play as \(figure.name.rawValue)"
        } else {
            figureButton.setImage(#imageLiteral(resourceName: "01_random"), for: .normal)
            figureLabel.text = "Play as random"
        }
    }
}
