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
    
    @IBOutlet private weak var signInView: UIStackView!
    
    private lazy var authUI = FUIAuth.defaultAuthUI()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInView.isHidden = true
        authUI.delegate = self
        authUI.providers = [FUIGoogleAuth()]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard Auth.auth().currentUser == nil else {
            Navigator(self).toMenu()
            return
        }
        
        signInView.isHidden = false
    }
    
    @IBAction private func signInTapped(_ sender: Any) {
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
}

extension SignInViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        guard error == nil else {
            print("didSignInWith error: \(error?.localizedDescription ?? "nil")")
            return
        }
        
        sub(AppModules.shared.matchingManager.createUser().subscribe(onCompleted: {
            Navigator(self).toMenu()
        }, onError: { error in
            fatalError(error.localizedDescription)
        }))
    }
}
