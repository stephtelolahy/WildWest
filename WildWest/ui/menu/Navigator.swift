//
//  Navigator.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 25/04/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import SafariServices

class Navigator {
    
    private unowned let viewController: UIViewController
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func toMenu() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let menuViewController =
            storyboard.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else {
                return
        }
        
        viewController.present(menuViewController, animated: true)
    }
    
    func toGame(environment: GameEnvironment) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let gameViewController =
            storyboard.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else {
                return
        }
        
        gameViewController.environment = environment
        viewController.present(gameViewController, animated: true)
    }
    
    func toContactUs() {
        let email = "stephano.telolahy@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
            openUrl(url)
        }
    }
    
    func toRules() {
        let rulesUrl = "http://www.dvgiochi.net/bang/bang_rules.pdf"
        if let url = URL(string: rulesUrl) {
            if #available(iOS 11.0, *) {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                let safariViewController = SFSafariViewController(url: url, configuration: config)
                viewController.present(safariViewController, animated: true)
            } else {
                openUrl(url)
            }
        }
    }
    
    func openUrl(_ url: URL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
