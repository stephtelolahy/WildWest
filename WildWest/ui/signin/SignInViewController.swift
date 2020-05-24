//
//  SignInViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 23/05/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import FirebaseUI

class SignInViewController: UIViewController {
    
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
        print("didSignInWith error: \(error?.localizedDescription ?? "nil")")
        
        if error == nil {
            Navigator(self).toMenu()
        }
    }
}
