//
//  AppDelegate.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 12/9/19.
//  Copyright © 2019 creativeGames. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import Resolver

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let mainVC = window?.rootViewController as? MainViewController {
            mainVC.router = Router(viewController: mainVC, dependencies: Resolver.resolve())
        }
        
        FirebaseApp.configure()
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        if let sourceApplication = options[.sourceApplication] as? String,
            FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
          return true
        }
        
        // other URL handling goes here.
        return false
    }
}
