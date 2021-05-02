//
//  MainViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import UIKit
import FirebaseUI
import RxSwift

class MainViewController: UINavigationController {
    
    // MARK: - Dependencies
    
    var userManager: UserManagerProtocol!
    var router: RouterProtocol!
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard userManager.isLoggedIn else {
            router.toMenu()
            return
        }
        
        observeUserStatus()
    }
    
    func observeUserStatus() {
        userManager.observeUserStatus().subscribe(onNext: { [weak self] status in
            switch status {
            case .waiting:
                self?.router.toWaitingRoom()
                
            case let .playing(gameId):
                self?.router.toOnlineGame(gameId)
                
            case .idle:
                self?.router.toMenu()
            }
        }).disposed(by: disposeBag)
    }
}
