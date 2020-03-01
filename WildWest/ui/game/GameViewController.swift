//
//  GameViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import RxSwift

class GameViewController: UIViewController, Subscribable, MoveSelectionable {
    
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
    var aiAgents: [AIPlayerAgentProtocol]?
    var controlledPlayerId: String?
    
    private let playersAdapter: PlayersAdapterProtocol = PlayersAdapter()
    private let actionsAdapter: ActionsAdapterProtocol = ActionsAdapter()
    private let messagesAdapter: MessagesAdapterProtocol = MessagesAdapter()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playersCollectionView.setItemSpacing(Constants.spacing)
        actionsCollectionView.setItemSpacing(Constants.spacing)
        
        playersAdapter.setControlledPlayerId(controlledPlayerId)
        actionsAdapter.setControlledPlayerId(controlledPlayerId)
        
        guard let engine = self.engine else {
            return
        }
        
        sub(engine.stateSubject.subscribe(onNext: { [weak self] state in
            self?.update(with: state)
        }))
        engine.start()
        
        aiAgents?.forEach { $0.start() }
    }
    
    // MARK: IBAction
    
    @IBAction private func menuButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Stats",
                                                style: .default,
                                                handler: { [weak self] _ in
                                                    self?.showStats()
        }))
        
        alertController.addAction(UIAlertAction(title: "Quit",
                                                style: .default,
                                                handler: { [weak self] _ in
                                                    self?.dismiss(animated: true)
        }))
        
        alertController.addAction(UIAlertAction(title: "Continue",
                                                style: .cancel,
                                                handler: nil))
        
        present(alertController, animated: true)
    }
    
    @IBAction private func actionsButtonTapped(_ sender: Any) {
        showStats()
    }
}

private extension GameViewController {
    
    func update(with state: GameStateProtocol) {
        playersAdapter.setState(state)
        actionsAdapter.setState(state)
        messagesAdapter.setState(state)
        playersCollectionView.reloadData()
        actionsCollectionView.reloadData()
        messageTableView.reloadDataSwollingAtBottom()
        titleLabel.text = messagesAdapter.title
        if let topDiscardCard = state.deck.last {
            discardImageView.image = UIImage(named: topDiscardCard.imageName)
        }
    }
    
    func showStats() {
        let viewController = StatsViewController()
        viewController.stateSubject = engine?.stateSubject
        present(viewController, animated: true)
    }
}

extension GameViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messagesAdapter.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell",
                                                       for: indexPath) as? MessageCell else {
                                                        return UITableViewCell()
        }
        
        cell.update(with: messagesAdapter.messages[indexPath.row])
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
        playersAdapter.items.count
    }
    
    private func actionsCollectionViewNumberOfItems() -> Int {
        actionsAdapter.items.count
    }
    
    private func playersCollectionView(_ collectionView: UICollectionView,
                                       cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: PlayerCell.self, for: indexPath)
        cell.update(with: playersAdapter.items[indexPath.row])
        return cell
    }
    
    private func actionsCollectionView(_ collectionView: UICollectionView,
                                       cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ActionCell.self, for: indexPath)
        cell.update(with: actionsAdapter.items[indexPath.row])
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
        selectMove(within: actionsAdapter.items[indexPath.row].actions) { [weak self] move in
            self?.engine?.execute(move)
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
