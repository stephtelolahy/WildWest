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
    
    // swiftlint:disable force_cast
    private lazy var engine: GameEngineProtocol = {
        let provider = ResourcesProvider(jsonReader: JsonReader(bundle: Bundle.main))
        let figures = provider.allFigures()
        let cards = provider.allCards()
        let gameSetup = GameSetup()
        let roles = gameSetup.roles(for: 7)
        let state = gameSetup.setupGame(roles: roles, figures: figures, cards: cards)
        let mutableState = state as! MutableGameStateProtocol
        let calculator = RangeCalculator()
        let rules: [RuleProtocol] = [
            BeerRule(),
            SaloonRule(),
            StagecoachRule(),
            WellsFargoRule(),
            EquipRule(),
            CatBalouRule(),
            PanicRule(calculator: calculator),
            BangRule(calculator: calculator),
            MissedRule(),
            GatlingRule(),
            IndiansRule(),
            JailRule(),
            DiscardBangRule(),
            DuelRule(),
            GeneralStoreRule(),
            ChooseCardRule(),
            LooseLifeRule(),
            StartTurnRule(),
            EndTurnRule(),
            ResolveJailRule(),
            ResolveDynamiteRule(),
            DiscardBeerRule(),
            ResolveBarrelRule()
        ]
        return GameEngine(state: state, mutableState: mutableState, rules: rules, calculator: OutcomeCalculator())
    }()
    
    private var state: GameStateProtocol?
    private let playersAdapter: PlayersAdapterProtocol = PlayersAdapter()
    private let actionsAdapter: ActionsAdapterProtocol = ActionsAdapter()
    private let aiAgent: AIProtocol = PlayAllHandAI()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playersCollectionView.setItemSpacing(spacing)
        actionsCollectionView.setItemSpacing(spacing)
        sub(engine.stateSubject.subscribe(onNext: { [weak self] state in
            self?.update(with: state)
        }))
    }
    
    // MARK: IBAction
    
    @IBAction private func actionsButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Autoplay",
                                                style: .default,
                                                handler: { [weak self] _ in
                                                    self?.autoPlay(1)
        }))
        
        alertController.addAction(UIAlertAction(title: "Commands",
                                                style: .default,
                                                handler: { [weak self] _ in
                                                    self?.showCommands()
        }))
        
        alertController.addAction(UIAlertAction(title: "Stats",
                                                style: .default,
                                                handler: { [weak self] _ in
                                                    self?.showStats()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))
        
        present(alertController, animated: true)
    }
}

private extension GameViewController {
    
    func update(with state: GameStateProtocol) {
        self.state = state
        playersAdapter.setState(state)
        actionsAdapter.setState(state)
        playersCollectionView.reloadData()
        title = state.mainMessage()
        DispatchQueue.main.async { [weak self] in
            self?.selectActivePlayer()
        }
    }
    
    func selectActivePlayer() {
        guard let activePlayerIndex = playersAdapter.items.firstIndex(where: { $0.isActive }) else {
            actionsCollectionView.reloadData()
            return
        }
        
        let indexPath = IndexPath(row: activePlayerIndex, section: 0)
        playersCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
        playersCollectionViewDidSelectItem(at: indexPath)
    }
    
    func showOptions(_ actions: [ActionProtocol]) {
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        actions.forEach { action in
            alertController.addAction(UIAlertAction(title: action.description,
                                                    style: .default,
                                                    handler: { [weak self] _ in
                                                        self?.engine.execute(action)
            }))
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))
        
        present(alertController, animated: true)
    }
    
    func autoPlay(_ intervalInSeconds: TimeInterval) {
        guard #available(iOS 10.0, *) else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: intervalInSeconds, repeats: true) { [weak self] timer in
            guard let state = self?.state,
                let command = self?.aiAgent.chooseCommand(in: state) else {
                    timer.invalidate()
                    return
            }
            
            self?.engine.execute(command)
        }
    }
    
    func showCommands() {
        let viewController = CommandsViewController()
        viewController.stateSubject = engine.stateSubject
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showStats() {
        let viewController = StatsViewController()
        viewController.stateSubject = engine.stateSubject
        navigationController?.pushViewController(viewController, animated: true)
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
        let actions = actionsAdapter.items[indexPath.row].actions
        guard !actions.isEmpty  else {
            return
        }
        
        showOptions(actions)
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

private extension GameStateProtocol {
    
    func mainMessage() -> String {
        if let outcome = self.outcome {
            return outcome.rawValue
        }
        
        if let challenge = self.challenge {
            return challenge.description
        }
        
        if actions.count == 1,
            let uniqueAction = actions.first {
            return uniqueAction.description
        }
        
        return "play any card"
    }
}
