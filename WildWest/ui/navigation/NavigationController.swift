//
//  NavigationController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import FirebaseUI

class NavigationController: UINavigationController, Subscribable {
    
    private lazy var manager: MatchingManagerProtocol = AppModules.shared.matchingManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            handleSignInCompleted()
        } else {
            loadSignIn()
        }
    }
}

private extension NavigationController {
    
    func handleSignInCompleted() {
        observeUserStatus()
    }
    
    func loadSignIn() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let signInViewController =
            storyboard.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else {
                return
        }
        
        signInViewController.onCompleted = { [weak self] in
            self?.handleSignInCompleted()
        }
        
        fade(to: signInViewController)
    }
    
    func loadMenu() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let menuViewController =
            storyboard.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else {
                return
        }
        
        menuViewController.onPlayLocal = { [weak self] in
            self?.loadLocalGame()
        }
        
        menuViewController.onPlayOnline = { [weak self] in
            guard let self = self else {
                return
            }
            
            self.sub(self.manager.addToWaitingRoom().subscribe())
        }
        
        fade(to: menuViewController)
    }
    
    func loadWaitingRoom() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let waitingRoomViewController =
            storyboard.instantiateViewController(withIdentifier: "WaitingRoomViewController")
                as? WaitingRoomViewController else {
                    return
        }
        
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
    
    func loadLocalGame() {
        loadGame(environment: GameBuilder().createLocalGameEnvironment())
    }
    
    func loadOnlineGame(_ gameId: String, _ playerId: String) {
        GameBuilder().createRemoteGameEnvironment(gameId: gameId, playerId: playerId) { [weak self] environment in
            self?.loadGame(environment: environment)
        }
    }
    
    func loadGame(environment: GameEnvironment) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let gameViewController =
            storyboard.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else {
                return
        }
        
        gameViewController.environment = environment
        
        gameViewController.onQuit = { [weak self] in
            self?.loadMenu()
            
            guard let self = self else {
                return
            }
            
            self.sub(self.manager.quitGame().subscribe())
        }
        
        fade(to: gameViewController)
    }
    
    func observeUserStatus() {
        sub(manager.observeUserStatus().subscribe(onNext: { [weak self] status in
            switch status {
            case .waiting:
                self?.loadWaitingRoom()
                
            case let .playing(gameId, playerId):
                self?.loadOnlineGame(gameId, playerId)
                
            default:
                self?.loadMenu()
            }
        }, onError: { error in
            fatalError(error.localizedDescription)
        }))
    }
}

extension UINavigationController {
    
    func fade(to viewController: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.type = .fade
        view.layer.add(transition, forKey: nil)
        setViewControllers([viewController], animated: false)
    }
}
