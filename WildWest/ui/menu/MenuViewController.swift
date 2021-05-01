//
//  MenuViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import UIKit
import Kingfisher
import WildWestEngine

class MenuViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var playersCountStepper: UIStepper!
    @IBOutlet private weak var playersCountLabel: UILabel!
    @IBOutlet private weak var roleButton: UIButton!
    @IBOutlet private weak var figureLabel: UILabel!
    @IBOutlet private weak var figureButton: UIButton!
    @IBOutlet private weak var roleLabel: UILabel!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    
    // MARK: - Dependencies
    
    var router: RouterProtocol!
    var preferences: UserPreferencesProtocol!
    var musicPlayer: SoundPlayerProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        figureButton.addBrownRoundedBorder()
        roleButton.addBrownRoundedBorder()
        setPlayersCount(preferences.playersCount)
        setFigure(preferences.preferredFigure)
        setRole(preferences.preferredRole)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        musicPlayer.play("2017-03-24_-_Lone_Rider_-_David_Fesliyan")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        musicPlayer.stop()
    }
    
    // MARK: - IBActions
    
    @IBAction private func playButtonTapped(_ sender: Any) {
        router.toLocalGame()
    }
    
    @IBAction private func onlineButtonTapped(_ sender: Any) {
        router.toOnlineGame()
    }
    
    @IBAction private func stepperValueChanged(_ sender: UIStepper) {
        let value = Int(sender.value)
        preferences.playersCount = value
        setPlayersCount(value)
    }
    
    @IBAction private func figureButtonTapped(_ sender: Any) {
        router.toFigureSelector { [weak self] figure in
            self?.preferences.preferredFigure = figure
            self?.setFigure(figure)
        }
    }
    
    @IBAction private func roleButtonTapped(_ sender: Any) {
        router.toRoleSelector { [weak self] role in
            self?.preferences.preferredRole = role
            self?.setRole(role)
        }
    }
    
    @IBAction private func contactButtonTapped(_ sender: Any) {
        router.toContactUs()
    }
    
    @IBAction private func logoButtonTapped(_ sender: Any) {
        router.toRules()
    }
}

// MARK: - Updates

private extension MenuViewController {
    
    func setPlayersCount(_ count: Int) {
        playersCountLabel.text = "\(count) players"
    }
    
    func setFigure(_ figure: String?) {
        figureButton.setImage(UIImage(named: figure ?? ""), for: .normal)
        figureLabel.text = "Play as \(figure ?? "random")"
    }
    
    func setRole(_ role: Role?) {
        roleButton.setImage(UIImage(named: role?.rawValue ?? ""), for: .normal)
        roleLabel.text = role?.rawValue ?? "random"
    }
}
