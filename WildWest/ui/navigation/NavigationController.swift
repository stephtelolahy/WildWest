//
//  NavigationController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import FirebaseUI
import Resolver
import RxSwift

class NavigationController: UINavigationController, Subscribable {
    
    private lazy var matchingManager: MatchingManagerProtocol = Resolver.resolve()
    private lazy var accountManager: AccountManagerProtocol = Resolver.resolve()
    private lazy var gameBuilder: GameBuilderProtocol = Resolver.resolve()
    private lazy var preferences: UserPreferencesProtocol = Resolver.resolve()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if accountManager.currentUser != nil {
            observeUserStatus()
        } else {
            loadSignIn()
        }
    }
}

private extension NavigationController {
    
    func loadSignIn() {
        let signInViewController = UIStoryboard.instantiate(SignInViewController.self, in: "Main")
        
        signInViewController.onCompleted = { [weak self] in
            self?.observeUserStatus()
        }
        
        fade(to: signInViewController)
    }
    
    func loadMenu() {
        let menuViewController = UIStoryboard.instantiate(MenuViewController.self, in: "Main")
        
        menuViewController.onPlayLocal = { [weak self] in
            self?.loadLocalGame()
        }
        
        menuViewController.onPlayOnline = { [weak self] in
            guard let self = self else {
                return
            }
            
            self.sub(self.matchingManager.addToWaitingRoom().subscribe())
        }
        
        fade(to: menuViewController)
    }
    
    func loadWaitingRoom() {
        let waitingRoomViewController = UIStoryboard.instantiate(WaitingRoomViewController.self, in: "Main")
        
        waitingRoomViewController.onQuit = { [weak self] in
            guard let self = self else {
                return
            }
            
            self.sub(self.matchingManager.quitWaitingRoom().subscribe())
        }
        
        waitingRoomViewController.onStart = { [weak self] users in
            guard let self = self else {
                return
            }
            
            self.sub(self.matchingManager.createGame(users: users).subscribe())
        }
        
        fade(to: waitingRoomViewController)
    }
    
    func loadLocalGame() {
        let state = gameBuilder.createGame(for: preferences.playersCount)
        let playerId = state.players.first?.identifier
        loadGame(environment: gameBuilder.createLocalGameEnvironment(state: state,
                                                                     playerId: playerId))
    }
    
    func loadOnlineGame(_ gameId: String, _ playerId: String) {
        sub(matchingManager.getGameData(gameId: gameId).subscribe(onSuccess: { state, users in
            let environment = self.gameBuilder.createRemoteGameEnvironment(gameId: gameId,
                                                                           playerId: playerId,
                                                                           state: state,
                                                                           users: users)
            // ⚠️ wait until GameSubjects emit lastest values
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.loadGame(environment: environment)
            }
        }))
    }
    
    func loadGame(environment: GameEnvironment) {
        let gameViewController = UIStoryboard.instantiate(GameViewController.self, in: "Main")
        
        gameViewController.environment = environment
        
        gameViewController.onQuit = { [weak self] in
            self?.loadMenu()
            
            guard let self = self else {
                return
            }
            
            self.sub(self.matchingManager.quitGame().subscribe())
        }
        
        fade(to: gameViewController)
    }
    
    func observeUserStatus() {
        sub(matchingManager.observeUserStatus().subscribe(onNext: { [weak self] status in
            switch status {
            case .waiting:
                self?.loadWaitingRoom()
                
            case let .playing(gameId, playerId):
                self?.loadOnlineGame(gameId, playerId)
                
            case .idle:
                self?.loadMenu()
            }
        }, onError: { error in
            fatalError(error.localizedDescription)
        }))
    }
}

private extension UINavigationController {
    
    func fade(to viewController: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.type = .fade
        view.layer.add(transition, forKey: nil)
        setViewControllers([viewController], animated: false)
    }
}
