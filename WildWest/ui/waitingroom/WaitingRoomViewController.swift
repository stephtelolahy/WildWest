//
//  WaitingRoomViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import Resolver

class WaitingRoomViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var userCollectionView: UICollectionView!
    @IBOutlet private weak var startButton: UIButton!
    
    // MARK: - Properties
    
    var onQuit: (() -> Void)?
    var onStart: (([UserInfo]) -> Void)?
    
//    private lazy var manager: MatchingManagerProtocol = Resolver.resolve()
    private var users: [UserInfo] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeWaitingUsers()
    }
    
    // MARK: - IBAction
    
    @IBAction private func quitButtonTapped(_ sender: Any) {
        onQuit?()
    }
    
    @IBAction private func startButtonTapped(_ sender: Any) {
        onStart?(users)
    }
    
    // MARK: - Private
    
    func observeWaitingUsers() {
//        sub(manager.observeWaitingUsers().subscribe(onNext: { [weak self] users in
//            self?.users = users
//            self?.userCollectionView.reloadData()
//            let minUsersCount = 2
//            self?.startButton.isHidden = users.count < minUsersCount
//        }))
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
