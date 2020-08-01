//
//  SignInViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/05/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import FirebaseUI

class SignInViewController: UIViewController, Subscribable {
    
    var onCompleted: (() -> Void)?
    
    private lazy var authUI = FUIAuth.defaultAuthUI()!
    private lazy var manager = AppModules.shared.matchingManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authUI.delegate = self
        authUI.providers = [FUIGoogleAuth()]
    }
    
    @IBAction private func signInTapped(_ sender: Any) {
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
}

extension SignInViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        guard error == nil else {
            presentAlert(title: "Sign in failed", message: error?.localizedDescription ?? "")
            return
        }
        
        sub(manager.createUser().subscribe(onCompleted: { [weak self] in
            self?.onCompleted?()
        }, onError: { error in
            fatalError(error.localizedDescription)
        }))
    }
}
