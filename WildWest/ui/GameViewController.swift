//
//  GameViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//

import UIKit
import RxSwift

class GameViewController: UIViewController, Subscribable {
    
    // MARK: Constants
    
    private let spacing: CGFloat = 4.0
    private let ratio: CGFloat = 250.0 / 389.0
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var playersCollectionView: UICollectionView!
    @IBOutlet private weak var actionsCollectionView: UICollectionView!
    
    // MARK: Properties
    
    private lazy var engine: GameEngineProtocol = {
        let provider = ResourcesProvider(jsonReader: JsonReader(bundle: Bundle.main))
        let figures = provider.allFigures()
        let cards = provider.allCards()
        let gameSetup = GameSetup()
        let roles = gameSetup.roles(for: 7)
        let state = gameSetup.setupGame(roles: roles, figures: figures, cards: cards)
        let calculator = RangeCalculator()
        let rules: [RuleProtocol] = [
            BeerRule(),
            SaloonRule(),
            StagecoachRule(),
            WellsFargoRule(),
            EquipRule(),
            CatBalouRule(),
            PanicRule(calculator: calculator),
            ShootRule(calculator: calculator),
            MissedRule(),
            GatlingRule(),
            IndiansRule(),
            DiscardBangRule(),
            DuelRule(),
            LooseLifeRule(),
            StartTurnRule(),
            EndTurnRule()
        ]
        return GameEngine(state: state, rules: rules)
    }()
    
    private var state: GameStateProtocol?
    private let playersAdapter: PlayersAdapterProtocol = PlayersAdapter()
    private let actionsAdapter: ActionsAdapterProtocol = ActionsAdapter()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playersCollectionView.setItemSpacing(spacing)
        actionsCollectionView.setItemSpacing(spacing)
        sub(engine.stateSubject.subscribe(onNext: { [weak self] state in
            self?.state = state
            self?.playersAdapter.setState(state)
            self?.actionsAdapter.setState(state)
            self?.playersCollectionView.reloadDataKeepingSelection { [weak self] in
                self?.actionsCollectionView.reloadData()
            }
        }))
    }
    
    // MARK: IBAction
    
    @IBAction private func historyButtonTapped(_ sender: Any) {
        guard let actions = state?.commands else {
            return
        }
        
        let actionsViewController = ActionsViewController()
        actionsViewController.actions = actions
        present(actionsViewController, animated: true)
    }
}

private extension GameViewController {
    
    func showOptions(of genericAction: GenericAction) {
        let alertController = UIAlertController(title: genericAction.name,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        genericAction.options.forEach { option in
            alertController.addAction(UIAlertAction(title: option.description,
                                                    style: .default,
                                                    handler: { [weak self] _ in
                                                        self?.engine.execute(option)
            }))
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))
        
        present(alertController, animated: true)
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
        return playersAdapter.items.count
    }
    
    private func actionsCollectionViewNumberOfItems() -> Int {
        return actionsAdapter.items.count
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
        actionsAdapter.setPlayerIdentifier(playersAdapter.items[indexPath.row].player?.identifier)
        actionsCollectionView.reloadData()
    }
    
    private func actionsCollectionViewDidSelectItem(at indexPath: IndexPath) {
        guard let action = actionsAdapter.items[indexPath.row].action else {
            return
        }
        
        showOptions(of: action)
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
        let totalHeight = collectionView.bounds.height - 4 * spacing
        let height = totalHeight / 3
        let totalWidth = collectionView.bounds.width - 4 * spacing
        let width = totalWidth / 3
        return CGSize(width: width, height: height)
    }
    
    private func actionCellSize(_ collectionView: UICollectionView) -> CGSize {
        let height: CGFloat = collectionView.bounds.height - 2 * spacing
        let width: CGFloat = height * ratio
        return CGSize(width: width, height: height)
    }
}
