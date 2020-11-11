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

class NavigationController: UINavigationController {
    
//    private lazy var manager: MatchingManagerProtocol = Resolver.resolve()
    private lazy var gameBuilder: GameBuilderProtocol = Resolver.resolve()
    private lazy var preferences: UserPreferencesProtocol = Resolver.resolve()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if manager.isLoggedIn {
//            observeUserStatus()
//        } else {
            loadMenu()
//        }
    }
}

private extension NavigationController {
    
    func loadMenu() {
        let menuViewController = UIStoryboard.instantiate(MenuViewController.self, in: "Main")
        
        menuViewController.onPlayLocal = { [weak self] in
            self?.loadLocalGame()
        }
        
        menuViewController.onPlayOnline = { [weak self] in
            self?.tryPlayOnline()
        }
        
        fade(to: menuViewController)
    }
    
    func tryPlayOnline() {
        /*
        guard manager.isLoggedIn else {
            requestSignIn()
            return
        }
        
        addToWaitingRoom()
        */
    }
    /*
    func addToWaitingRoom() {
        sub(manager.addToWaitingRoom().subscribe())
    }
    */
    func requestSignIn() {
        let alertController = UIAlertController(title: "Authentication required",
                                                message: "Get started to online game by signin to your account",
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Sign in",
                                                style: .default,
                                                handler: { [weak self] _ in
                                                    self?.loadSignIn()
        }))
        
        alertController.addAction(UIAlertAction(title: "Continue as guest",
                                                style: .default,
                                                handler: { [weak self] _ in
                                                    self?.enterPseudo(completion: { pseudo in
                                                        self?.signinAnonymously(pseudo: pseudo)
                                                    })
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))
        
        present(alertController, animated: true)
    }
    
    func loadSignIn() {
        guard let authUI = FUIAuth.defaultAuthUI() else {
            return
        }
        
        authUI.delegate = self
        authUI.providers = [FUIGoogleAuth()]
        present(authUI.authViewController(), animated: true)
    }
    
    func enterPseudo(completion: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: "Guest", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Enter pseudo"
        }
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            let textField = alertController.textFields![0] as UITextField
            completion(textField.text!)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true)
    }
    
    func signinAnonymously(pseudo: String) {
        Auth.auth().signInAnonymously { [weak self] authResult, _ in
            guard let user = authResult?.user else {
                return
            }
            
            self?.handleSigninCompleted(user, pseudo: pseudo)
        }
    }
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
    func loadLocalGame() {
        let state = gameBuilder.createGame(for: preferences.playersCount)
        let playerId = state.playOrder.first
        let environment = gameBuilder.createLocalGameEnvironment(state: state, playerId: playerId)
        loadGame(environment: environment)
    }
    
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
    
    func loadGame(environment: GameEnvironment) {
        let gameViewController = UIStoryboard.instantiate(GameViewController.self, in: "Main")
        
        gameViewController.environment = environment
        
        gameViewController.onQuit = { [weak self] in
            guard let self = self else {
                return
            }
            
            self.loadMenu()
//            self.sub(self.manager.quitGame().subscribe())
        }
        
        fade(to: gameViewController)
    }
    
    func observeUserStatus() {
        /*
        sub(manager.observeUserStatus().subscribe(onNext: { [weak self] status in
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
 */
    }
    
    func handleSigninCompleted(_ user: User, pseudo: String? = nil) {
        /*
        let wuser: WUserInfo
        
        if user.isAnonymous {
            wuser = WUserInfo(id: user.uid,
                              name: pseudo ?? user.uid,
                              photoUrl: "https://i.pinimg.com/236x/86/69/26/866926c527318527f2b3704e89fabc2e.jpg")
        } else {
            wuser = WUserInfo(id: user.uid,
                              name: user.displayName ?? "",
                              photoUrl: user.photoURL?.absoluteString ?? "")
        }
        
        sub(manager.createUser(wuser).subscribe(onCompleted: { [weak self] in
            self?.observeUserStatus()
            self?.addToWaitingRoom()
        }))
 */
    }
}

extension NavigationController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        guard let user = authDataResult?.user else {
            return
        }
        
        handleSigninCompleted(user)
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
