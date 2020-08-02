//
//  MenuViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 01/03/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher
import Resolver

class MenuViewController: UIViewController, Subscribable {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var playersCountStepper: UIStepper!
    @IBOutlet private weak var playersCountLabel: UILabel!
    @IBOutlet private weak var roleButton: UIButton!
    @IBOutlet private weak var figureLabel: UILabel!
    @IBOutlet private weak var figureButton: UIButton!
    @IBOutlet private weak var roleLabel: UILabel!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    
    // MARK: - Properties
    
    var onPlayLocal: (() -> Void)?
    var onPlayOnline: (() -> Void)?
    
    private lazy var manager: MatchingManager = Resolver.resolve()
    private lazy var preferences: UserPreferencesProtocol = Resolver.resolve()
    private lazy var gameResources: GameResourcesProtocol = Resolver.resolve()
    private lazy var musicPlayer: ThemeMusicPlayer? = preferences.enableSound ? ThemeMusicPlayer() : nil
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        figureButton.addBrownRoundedBorder()
        roleButton.addBrownRoundedBorder()
        updatePlayersCount()
        updateFigureImage()
        updateRoleImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        musicPlayer?.play()
        updateUserView()
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
        preferences.playersCount = Int(playersCountStepper.value)
        updatePlayersCount()
    }
    
    @IBAction private func figureButtonTapped(_ sender: Any) {
        let figureSelector = FigureSelector(completion: { [weak self] _ in
            self?.updateFigureImage()
        })
        present(figureSelector, animated: true)
    }
    
    @IBAction private func roleButtonTapped(_ sender: Any) {
        let roleSelector = RoleSelector(completion: { [weak self] _ in
            self?.updateRoleImage()
        })
        present(roleSelector, animated: true)
    }
    
    @IBAction private func contactButtonTapped(_ sender: Any) {
        toContactUs()
    }
    
    @IBAction private func logoButtonTapped(_ sender: Any) {
        toRules()
    }
}

// MARK: - Updates

private extension MenuViewController {
    
    func updatePlayersCount() {
        playersCountLabel.text = "\(preferences.playersCount) players"
    }
    
    func updateFigureImage() {
        let allFigures = gameResources.allFigures
        if let figure = allFigures.first(where: { $0.name == preferences.preferredFigure }) {
            figureButton.setImage(UIImage(named: figure.imageName), for: .normal)
            figureLabel.text = "Play as \(figure.name.rawValue)"
        } else {
            figureButton.setImage(#imageLiteral(resourceName: "01_random"), for: .normal)
            figureLabel.text = "Play as random"
        }
    }
    
    func updateRoleImage() {
        if let role = preferences.preferredRole {
            roleButton.setImage(role.image(), for: .normal)
            roleLabel.text = role.rawValue
        } else {
            roleButton.setImage(#imageLiteral(resourceName: "01_random"), for: .normal)
            roleLabel.text = "random"
        }
    }
    
    func updateUserView() {
        sub(manager.getUser().subscribe(onSuccess: { [weak self] user in
            self?.avatarImageView.kf.setImage(with: URL(string: user.photoUrl))
            self?.userNameLabel.text = user.name
        }, onError: { [weak self] _ in
            self?.avatarImageView.image = nil
            self?.userNameLabel.text = nil
        }))
    }
}
