//
//  GameViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: Constants
    private let spacing: CGFloat = 4.0
    private let ratio: CGFloat = 250.0 / 389.0
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var stateCollectionView: UICollectionView!
    @IBOutlet private weak var handCollectionView: UICollectionView!
    
    // MARK: Properties
    
    private lazy var state: GameStateProtocol = {
        let resources = GameResources(jsonReader: JsonReader(bundle: Bundle.main))
        let figures = resources.allFigures()
        let cards = resources.allCards()
        let gameSetup = GameSetup()
        let roles = gameSetup.roles(for: 7)
        return gameSetup.setupGame(roles: roles, figures: figures, cards: cards)
    }()
    
    private var cards: [CardProtocol] = []
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        stateCollectionView.setItemSpacing(spacing)
        handCollectionView.setItemSpacing(spacing)
    }
}

extension GameViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView == stateCollectionView {
            return stateCollectionViewNumberOfItems()
        } else {
            return handCollectionViewNumberOfItems()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == stateCollectionView {
            return stateCollectionView(collectionView, cellForItemAt: indexPath)
        } else {
            return handCollectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    private func stateCollectionViewNumberOfItems() -> Int {
        return 9
    }
    
    private func handCollectionViewNumberOfItems() -> Int {
        return cards.count
    }
    
    private func stateCollectionView(_ collectionView: UICollectionView,
                                     cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: PlayerCell.self, for: indexPath)
        if let player = player(at: indexPath) {
            cell.update(with: player)
        } else {
            cell.clear()
        }
        return cell
    }
    
    private func handCollectionView(_ collectionView: UICollectionView,
                                    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: CardCell.self, for: indexPath)
        cell.update(with: cards[indexPath.row])
        return cell
    }
    
}

extension GameViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == stateCollectionView {
            stateCollectionViewDidSelectItem(at: indexPath)
        } else {
            handCollectionViewDidSelectItem(at: indexPath)
        }
    }
    
    private func stateCollectionViewDidSelectItem(at indexPath: IndexPath) {
        if let player = player(at: indexPath) {
            cards = player.hand.cards
        } else {
            cards = []
        }
        handCollectionView.reloadData()
    }
    
    private func handCollectionViewDidSelectItem(at indexPath: IndexPath) {
    }
}

extension GameViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == stateCollectionView {
            return stateCellSize(collectionView)
        } else {
            return handCellSize(collectionView)
        }
    }
    
    private func stateCellSize(_ collectionView: UICollectionView) -> CGSize {
        let totalHeight = collectionView.bounds.height - 4 * spacing
        let height = totalHeight / 3
        let totalWidth = collectionView.bounds.width - 4 * spacing
        let width = totalWidth / 3
        return CGSize(width: width, height: height)
    }
    
    private func handCellSize(_ collectionView: UICollectionView) -> CGSize {
        let height: CGFloat = collectionView.bounds.height - 2 * spacing
        let width: CGFloat = height * ratio
        return CGSize(width: width, height: height)
    }
}

private extension GameViewController {
    
    var playerIndexes: [[Int]] {
        return [
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 1, 0, 0, 0, 0, 0],
            [0, 0, 0, 1, 0, 2, 0, 0, 0],
            [1, 0, 2, 0, 0, 0, 0, 3, 0],
            [1, 0, 2, 0, 0, 0, 4, 0, 3],
            [1, 2, 3, 0, 0, 0, 5, 0, 4],
            [1, 0, 2, 6, 0, 3, 5, 0, 4],
            [1, 2, 3, 7, 0, 4, 6, 0, 5]
        ]
    }
    
    func player(at indexPath: IndexPath) -> PlayerProtocol? {
        let playerIndex = playerIndexes[state.players.count][indexPath.row] - 1
        guard playerIndex >= 0 else {
            return nil
        }
        return state.players[playerIndex]
    }
}
