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
        
        guard userManager.isLoggedIn else {
            router.toMenu()
            return
        }
        
        observeUserStatus()
    }
}

private extension MainViewController {
    /*
    func loadWaitingRoom() {
        let waitingRoomViewController = UIStoryboard.instantiate(WaitingRoomViewController.self, in: "Main")
        
        waitingRoomViewController.onQuit = { [weak self] in
            guard let self = self else {
                return
            }
            
            self.sub(self.manager.quitWaitingRoom().subscribe())
        }
        
        waitingRoomViewController.onStart = { [weak self] users in
            guard let self = self else {
                return
            }
            
            self.sub(self.manager.createGame(users: users).subscribe())
        }
        
        fade(to: waitingRoomViewController)
    }
    */
    
    func loadOnlineGame(_ gameId: String, _ playerId: String) {
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
    
    func observeUserStatus() {
        userManager.observeUserStatus().subscribe(onNext: { [weak self] status in
            switch status {
            case .waiting:
                self?.router.toWaitingRoom()
                
            case let .playing(gameId, playerId):
                self?.loadOnlineGame(gameId, playerId)
                
            case .idle:
                self?.router.toMenu()
            }
        }, onError: { error in
            fatalError(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}
