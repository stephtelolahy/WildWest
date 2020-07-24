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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            loadMenu()
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
