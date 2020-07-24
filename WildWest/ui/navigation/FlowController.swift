//
//  FlowController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import FirebaseUI

class FlowController: UINavigationController, Subscribable {
    
    private lazy var matchingManager = AppModules.shared.matchingManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            loadMenu()
            observeUserStatus()
        } else {
            loadSignIn()
        }
    }
}

private extension FlowController {
    
    func loadSignIn() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let signInViewController =
            storyboard.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else {
                return
        }
        
        signInViewController.onCompleted = { [weak self] in
            self?.loadMenu()
            self?.observeUserStatus()
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
        
        fade(to: menuViewController)
    }
    
    func loadWaitingRoom() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let waitingRoomViewController =
            storyboard.instantiateViewController(withIdentifier: "WaitingRoomViewController") as? WaitingRoomViewController else {
                return
        }
        
        fade(to: waitingRoomViewController)
    }
    
    func loadLocalGame() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let gameViewController =
            storyboard.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else {
                return
        }
        
        gameViewController.environment = GameLauncher().createLocalGame()
        
        gameViewController.onCompleted = { [weak self] in
            self?.loadMenu()
        }
        
        fade(to: gameViewController)
    }
    
    func loadOnlineGame(_ gameId: String, _ playerId: String) {
        print("loadOnlineGame \(gameId), \(playerId)")
    }
    
    func observeUserStatus() {
        sub(matchingManager.observeUserStatus().subscribe(onNext: { [weak self] status in
            self?.processUserStatus(status)
        }, onError: { error in
            fatalError(error.localizedDescription)
        }))
    }
    
    func processUserStatus(_ status: UserStatus) {
        print("user status: \(String(describing: status))")
        switch status {
        case .waiting:
            loadWaitingRoom()
            
        case let .playing(gameId, playerId):
            loadOnlineGame(gameId, playerId)
            
        default:
            loadMenu()
        }
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
