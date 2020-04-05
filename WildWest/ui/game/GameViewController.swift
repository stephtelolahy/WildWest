//
//  GameViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable function_body_length

import UIKit
import RxSwift

class GameViewController: UIViewController, Subscribable {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var endTurnButton: UIButton!
    @IBOutlet private weak var playersCollectionView: UICollectionView!
    @IBOutlet private weak var actionsCollectionView: UICollectionView!
    @IBOutlet private weak var messageTableView: UITableView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var discardImageView: UIImageView!
    
    // MARK: Properties
    
    var engine: GameEngineProtocol?
    var aiAgents: [AIPlayerAgentProtocol] = []
    var controlledPlayerId: String?
    
    private var playerItems: [PlayerItem] = []
    private var actionItems: [ActionItem] = []
    private var messages: [String] = []
    private var scores: [String: Int] = [:]
    private var endTurnMoves: [GameMove] = []
    
    private lazy var playerAdapter = PlayersAdapter()
    private lazy var actionsAdapter = ActionsAdapter()
    private lazy var moveDescriptor = MoveDescriptor()
    private lazy var moveSoundPlayer = MoveSoundPlayer()
    private lazy var statsBuilder = StatsBuilder()
    private lazy var instructionBuilder = InstructionBuilder()
    private lazy var playMoveSelector = PlayMoveSelector(viewController: self)
    private lazy var reactionMoveSelector = ReactionMoveSelector(viewController: self)
    private lazy var playerDescriptor = PlayerDescriptor(viewController: self)
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = playersCollectionView.collectionViewLayout as? GameCollectionViewLayout
        layout?.delegate = self
        
        guard let engine = self.engine else {
            return
        }
        
        sub(engine.state(observedBy: controlledPlayerId).subscribe(onNext: { [weak self] state in
            self?.update(with: state)
        }))
        
        engine.start()
        aiAgents.forEach { $0.start() }
    }
    
    // MARK: IBAction
    
    @IBAction private func menuButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction private func endTurnTapped(_ sender: Any) {
        playMoveSelector.selectMove(within: endTurnMoves) { [weak self] move in
            self?.engine?.queue(move)
        }
    }
}

private extension GameViewController {
    
    func update(with state: GameStateProtocol) {
        
        scores = statsBuilder.buildScore(state: state)
        
        playerItems = playerAdapter.buildItems(state: state, scores: scores)
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
        
        actionItems = actionsAdapter.buildActions(state: state, for: controlledPlayerId)
        actionsCollectionView.reloadData()
        titleLabel.text = instructionBuilder.buildInstruction(state: state, for: controlledPlayerId)
        
        if let outcome = state.outcome {
            showGameOver(outcome: outcome)
        }
        
        if state.challenge != nil,
            let controlledPlayerId = self.controlledPlayerId,
            let reactionMoves = state.validMoves[controlledPlayerId] {
            reactionMoveSelector.selectMove(within: reactionMoves, state: state) { [weak self] move in
                self?.engine?.queue(move)
            }
        }
        
        endTurnMoves = []
        if let controlledPlayerId = self.controlledPlayerId,
            let moves = state.validMoves[controlledPlayerId] {
            endTurnMoves = moves.filter { $0.name == .endTurn }
        }
        
        endTurnButton.isEnabled = !endTurnMoves.isEmpty
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
        
        forcePresent(alertController, animated: true)
    }
}

extension GameViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: MessageCell.self, for: indexPath)
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
        playerDescriptor.display(playerItems[indexPath.row].player)
    }
    
    private func actionsCollectionViewDidSelectItem(at indexPath: IndexPath) {
        let moves = actionItems[indexPath.row].moves
        playMoveSelector.selectMove(within: moves) { [weak self] move in
            self?.engine?.queue(move)
        }
    }
}

extension GameViewController: GameCollectionViewLayoutDelegate {
    
    func numberOfItemsForGameCollectionViewLayout(layout: GameCollectionViewLayout) -> Int {
        guard let engine = self.engine else {
            return 0
        }
        
        return engine.allPlayersCount
    }
}
