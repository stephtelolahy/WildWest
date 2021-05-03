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
                
            case let .playing(gameId):
                self?.toOnlineGame(gameId)
                
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
    
    func toOnlineGame(_ gameId: String) {
        // TODO: implement
        /*
         sub(manager.getGameData(gameId: gameId).subscribe(onSuccess: { state, users in
             let environment = self.gameBuilder.createRemoteGameEnvironment(gameId: gameId,
                                                                            playerId: playerId,
                                                                            state: state,
                                                                            users: users)
             // ⚠️ wait until GameSubjects emit lastest values
             DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                 self?.loadGame(environment: environment)
             }
         }))
         */
    }
}
