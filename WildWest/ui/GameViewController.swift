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
    
    @IBOutlet private weak var stateCollectionView: UICollectionView!
    @IBOutlet private weak var handCollectionView: UICollectionView!
    
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
            StartTurnRule(),
            EndTurnRule(),
            ShootRule(calculator: calculator),
            MissedRule(),
            GatlingRule(),
            LooseLifeRule(),
            IndiansRule(),
            DiscardBangRule(),
            DuelRule()
        ]
        return GameEngine(state: state, rules: rules)
    }()
    
    // swiftlint:disable implicitly_unwrapped_optional
    private var state: GameStateProtocol!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stateCollectionView.setItemSpacing(spacing)
        handCollectionView.setItemSpacing(spacing)
        sub(engine.stateSubject.subscribe(onNext: { [weak self] state in
            self?.state = state
            self?.stateCollectionView.reloadDataKeepingSelection { [weak self] in
                self?.handCollectionView.reloadData()
            }
        }))
    }
    
    // MARK: IBAction
    
    @IBAction private func historyButtonTapped(_ sender: Any) {
        let actionsViewController = ActionsViewController()
        actionsViewController.actions = state.commands
        present(actionsViewController, animated: true)
    }
}

extension GameViewController: ActionsViewControllerDelegate {
    func actionsViewController(_ controller: ActionsViewController, didSelect action: ActionProtocol) {
        engine.execute(action)
    }
}

/// Convenience
private extension GameViewController {
    
    var cards: [CardProtocol] {
        guard let indexPath = stateCollectionView.indexPathsForSelectedItems?.first,
            let player = player(at: indexPath) else {
                return []
        }
        
        return player.hand
    }
    
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
    
    func showActionsForPlayer(at indexPath: IndexPath) {
        guard let player = player(at: indexPath) else {
            return
        }
        
        let genericActions = state.actions.filter({ $0.actorId == player.identifier })
        guard !genericActions.isEmpty else {
            return
        }
        
        let alertController = UIAlertController(title: player.ability.rawValue,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        genericActions.forEach { genericAction in
            let title = "\(genericAction.name) (\(genericAction.options.count))"
            alertController.addAction(UIAlertAction(title: title, style: .default, handler: { [weak self] _ in
                if genericAction.options.count == 1 {
                    self?.engine.execute(genericAction.options[0])
                } else {
                    self?.showOptions(of: genericAction)
                }
                
            }))
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))
        
        present(alertController, animated: true)
    }
    
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
            let isActive = state.actions.contains(where: { $0.actorId == player.identifier })
            cell.update(with: player, isActive: isActive)
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
        handCollectionView.reloadData()
        showActionsForPlayer(at: indexPath)
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
