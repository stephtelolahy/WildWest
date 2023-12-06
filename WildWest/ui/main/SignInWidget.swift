//
//  SignInWidget.swift
//  WildWest
//
//  Created by Hugues Stéphano TELOLAHY on 02/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import UIKit
import FirebaseAuth
import RxSwift

class SignInWidget: NSObject {
    
    private weak var viewController: UIViewController?
    private let userManager: UserManagerProtocol
    
    private let disposeBag = DisposeBag()
    private var completion: ((UserInfo) -> Void)?
    
    init(viewController: UIViewController, userManager: UserManagerProtocol) {
        self.viewController = viewController
        self.userManager = userManager
    }
    
    func signIn(completion: @escaping (UserInfo) -> Void) {
        let alertController = UIAlertController(title: "Authentication required",
                                                message: "Get started to online game by signin to your account",
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Sign in",
                                                style: .default,
                                                handler: { [weak self] _ in
                                                    self?.toGoogleSignIn(completion)
                                                }))
        
        alertController.addAction(UIAlertAction(title: "Continue as guest",
                                                style: .cancel,
                                                handler: { [weak self] _ in
                                                    self?.toAnonymousSignIn(completion)
                                                }))
        
        viewController?.present(alertController, animated: true)
    }
}

private extension SignInWidget {
    
    func toGoogleSignIn(_ completion: @escaping (UserInfo) -> Void) {
        guard let authUI = FUIAuth.defaultAuthUI() else {
            return
        }
        
        authUI.delegate = self
        authUI.providers = [FUIGoogleAuth()]
        viewController?.present(authUI.authViewController(), animated: true)
        self.completion = completion
    }
    
    func toAnonymousSignIn(_ completion: @escaping (UserInfo) -> Void) {
        let alertController = UIAlertController(title: "Guest", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Enter pseudo"
        }
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            let textField = alertController.textFields![0] as UITextField
            let pseudo = textField.text!
            Auth.auth().signInAnonymously { [weak self] authResult, _ in
                guard let user = authResult?.user else {
                    return
                }
                
                self?.handleSigninCompleted(user, pseudo: pseudo, completion: completion)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        viewController?.present(alertController, animated: true)
    }
    
    func handleSigninCompleted(_ user: User, pseudo: String? = nil, completion: ((UserInfo) -> Void)? = nil) {
        let userInfo: UserInfo
        
        if user.isAnonymous {
            userInfo = UserInfo(id: user.uid,
                                name: pseudo ?? user.uid,
                                photoUrl: "https://i.pinimg.com/236x/86/69/26/866926c527318527f2b3704e89fabc2e.jpg")
        } else {
            userInfo = UserInfo(id: user.uid,
                                name: user.displayName ?? "",
                                photoUrl: user.photoURL?.absoluteString ?? "")
        }
        
        userManager.createUser(userInfo).subscribe(onCompleted: {
            completion?(userInfo)
        }).disposed(by: disposeBag)
    }
}

extension SignInWidget: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        guard let user = authDataResult?.user else {
            return
        }
        
        handleSigninCompleted(user, completion: completion)
    }
}
