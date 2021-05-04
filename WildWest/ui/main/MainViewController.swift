//
//  MainViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import UIKit
import FirebaseUI
import RxSwift

class MainViewController: UINavigationController {
    
    // MARK: - Dependencies
    
    var userManager: UserManagerProtocol!
    var gameManager: GameManagerProtocol!
    var router: RouterProtocol!
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userManager.isLoggedIn {
            observeUserStatus()
        } else {
            observeSignIn()
            router.toMenu()
        }
    }
}

private extension MainViewController {
    
    func observeUserStatus() {
        userManager.observeUserStatus().subscribe(onNext: { [weak self] status in
            switch status {
            case .waiting:
                self?.router.toWaitingRoom()
                
            case let .playing(gameId, playerId):
                self?.toOnlineGame(gameId: gameId, playerId: playerId)
                
            case .idle:
                self?.router.toMenu()
            }
        }).disposed(by: disposeBag)
    }
    
    func observeSignIn() {
        NotificationCenter.default.addObserver(forName: .didSingIn, object: nil, queue: .main) { [weak self] _ in
            self?.observeUserStatus()
        }
    }
    
    func toOnlineGame(gameId: String, playerId: String) {
        gameManager.joinRemoteGame(gameId: gameId, playerId: playerId).subscribe(onSuccess: { [weak self] environment in
            self?.router.toGame(environment)
        }).disposed(by: disposeBag)
    }
}
