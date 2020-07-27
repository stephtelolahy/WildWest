//
//  WaitingRoomViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/07/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

class WaitingRoomViewController: UIViewController, Subscribable {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var userCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    var onQuit: (() -> Void)?
    var onStart: (() -> Void)?
    
    private var users: [WUserInfo] = []
    private lazy var manager: MatchingManagerProtocol = AppModules.shared.matchingManager
    
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
        onStart?()
    }
    
    // MARK: - Private
    
    func observeWaitingUsers() {
        sub(manager.observeWaitingUsers().subscribe(onNext: { [weak self] users in
            self?.users = users
            self?.userCollectionView.reloadData()
        }))
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
