//
//  WaitingRoomViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import UIKit
import RxSwift

class WaitingRoomViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var userCollectionView: UICollectionView!
    @IBOutlet private weak var startButton: UIButton!
    
    // MARK: - Dependencies
    
    var router: RouterProtocol!
    var userManager: UserManagerProtocol!
    var gameManager: GameManagerProtocol!
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Data
    
    private var users: [UserInfo] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeWaitingUsers()
    }
    
    // MARK: - IBAction
    
    @IBAction private func quitButtonTapped(_ sender: Any) {
        userManager.setStatusIdle().subscribe().disposed(by: disposeBag)
        router.toMenu()
    }
    
    @IBAction private func startButtonTapped(_ sender: Any) {
        gameManager.createRemoteGame(users: users).subscribe().disposed(by: disposeBag)
    }
    
    // MARK: - Private
    
    func observeWaitingUsers() {
        userManager.observeWaitingUsers().subscribe(onNext: { [weak self] users in
            self?.users = users
            self?.userCollectionView.reloadData()
            let minUsersCount = 2
            self?.startButton.isHidden = users.count < minUsersCount
        }).disposed(by: disposeBag)
    }
}

extension WaitingRoomViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        users.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: UserCell.self, for: indexPath)
        cell.update(with: users[indexPath.row])
        return cell
    }
}

extension WaitingRoomViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height
        return CGSize(width: height, height: height)
    }
}
