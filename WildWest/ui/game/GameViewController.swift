//
//  GameViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import RxSwift

class GameViewController: UIViewController,
Subscribable, MoveSelector, ActionsAdapter, InstructionBuilder, StatsBuilder {
    
    // MARK: Constants
    
    private enum Constants {
        static let spacing: CGFloat = 4.0
        static let ratio: CGFloat = 250.0 / 389.0
    }
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var playersCollectionView: UICollectionView!
    @IBOutlet private weak var actionsCollectionView: UICollectionView!
    @IBOutlet private weak var messageTableView: UITableView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var discardImageView: UIImageView!
    
    // MARK: Properties
    
    var engine: GameEngineProtocol?
    var aiAgents: [AIPlayerAgentProtocol] = []
    var controlledPlayerId: String?
    
    private var playerIndexes: [Int: String] = [:]
    private var playerItems: [PlayerItem?] = []
    private var actionItems: [ActionItem] = []
    private var messages: [String] = []
    private var antiSheriffScore: [AgressivityStat] = []
    
    private lazy var playerAdapter = PlayersAdapter()
    private lazy var moveDescriptor = MoveDescriptor()
    private lazy var moveSoundPlayer = MoveSoundPlayer()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playersCollectionView.setItemSpacing(Constants.spacing)
        actionsCollectionView.setItemSpacing(Constants.spacing)
        
        guard let engine = self.engine else {
            return
        }
        
        sub(engine.observeAs(playerId: controlledPlayerId).subscribe(onNext: { [weak self] state in
            self?.update(with: state)
        }))
        
        engine.start()
        aiAgents.forEach { $0.start() }
    }
    
    // MARK: IBAction
    
    @IBAction private func menuButtonTapped(_ sender: Any) {
        showStats()
    }
}

private extension GameViewController {
    
    func update(with state: GameStateProtocol) {
        
        if playerIndexes.isEmpty {
            let playerIds = state.players.map { $0.identifier }
            playerIndexes = playerAdapter.buildIndexes(playerIds: playerIds, controlledId: controlledPlayerId)
        }
        
        antiSheriffScore = buildAntiSheriffScore(state: state)
        
        playerItems = playerAdapter.buildItems(state: state, for: controlledPlayerId, playerIndexes: playerIndexes)
        playersCollectionView.reloadData()
        
        if let topDiscardPile = state.discardPile.first {
            discardImageView.image = UIImage(named: topDiscardPile.imageName)
        } else {
            discardImageView.image = nil
        }
        
        if let lastMove = state.executedMoves.last {
            messages.append(moveDescriptor.description(for: lastMove))
            messageTableView.reloadDataSwollingAtBottom()
            
            moveSoundPlayer.playSound(for: lastMove)
        }
        
        actionItems = buildActions(state: state, for: controlledPlayerId)
        actionsCollectionView.reloadData()
        titleLabel.text = buildInstruction(state: state, for: controlledPlayerId)
        
        if let outcome = state.outcome {
            showGameOver(outcome: outcome)
        }
    }
    
    func showGameOver(outcome: GameOutcome) {
        let alertController = UIAlertController(title: "Game Over",
                                                message: outcome.rawValue,
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: .cancel,
                                                handler: { [weak self] _ in
                                                    self?.dismiss(animated: true)
        }))
        
        present(alertController, animated: true)
    }
    
    func showStats() {
        
        let message = antiSheriffScore
            .map { "\($0.source) : \($0.value)" }
            .joined(separator: "\n")
        
        let alertController = UIAlertController(title: "Anti-Sheriff Stats",
                                                message: message,
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: .cancel,
                                                handler: nil))
        
        present(alertController, animated: true)
    }
}

extension GameViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell",
                                                       for: indexPath) as? MessageCell else {
                                                        return UITableViewCell()
        }
        
        cell.update(with: messages[indexPath.row])
        return cell
    }
}

extension GameViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView == playersCollectionView {
            return playersCollectionViewNumberOfItems()
        } else {
            return actionsCollectionViewNumberOfItems()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == playersCollectionView {
            return playersCollectionView(collectionView, cellForItemAt: indexPath)
        } else {
            return actionsCollectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    private func playersCollectionViewNumberOfItems() -> Int {
        playerItems.count
    }
    
    private func actionsCollectionViewNumberOfItems() -> Int {
        actionItems.count
    }
    
    private func playersCollectionView(_ collectionView: UICollectionView,
                                       cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: PlayerCell.self, for: indexPath)
        cell.update(with: playerItems[indexPath.row])
        return cell
    }
    
    private func actionsCollectionView(_ collectionView: UICollectionView,
                                       cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ActionCell.self, for: indexPath)
        cell.update(with: actionItems[indexPath.row])
        return cell
    }
}

extension GameViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == playersCollectionView {
            playersCollectionViewDidSelectItem(at: indexPath)
        } else {
            actionsCollectionViewDidSelectItem(at: indexPath)
        }
    }
    
    private func playersCollectionViewDidSelectItem(at indexPath: IndexPath) {
    }
    
    private func actionsCollectionViewDidSelectItem(at indexPath: IndexPath) {
        selectMove(within: actionItems[indexPath.row].actions) { [weak self] move in
            self?.engine?.queue(move)
        }
    }
}

extension GameViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == playersCollectionView {
            return playerCellSize(collectionView)
        } else {
            return actionCellSize(collectionView)
        }
    }
    
    private func playerCellSize(_ collectionView: UICollectionView) -> CGSize {
        let totalHeight = collectionView.bounds.height - 4 * Constants.spacing
        let height = totalHeight / 3
        let totalWidth = collectionView.bounds.width - 4 * Constants.spacing
        let width = totalWidth / 3
        return CGSize(width: width, height: height)
    }
    
    private func actionCellSize(_ collectionView: UICollectionView) -> CGSize {
        let height: CGFloat = collectionView.bounds.height - 2 * Constants.spacing
        let width: CGFloat = height * Constants.ratio
        return CGSize(width: width, height: height)
    }
}
