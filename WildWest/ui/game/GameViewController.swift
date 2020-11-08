//
//  GameViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable implicitly_unwrapped_optional

import UIKit
import RxSwift
import Resolver
import CardGameEngine

class GameViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var endTurnButton: UIButton!
    @IBOutlet private weak var otherMovesButton: UIButton!
    @IBOutlet private weak var playersCollectionView: UICollectionView!
    @IBOutlet private weak var handCollectionView: UICollectionView!
    @IBOutlet private weak var messageTableView: UITableView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var discardImageView: UIImageView!
    @IBOutlet private weak var deckImageView: UIImageView!
    @IBOutlet private weak var deckCountLabel: UILabel!
    
    // MARK: Properties
    
    var environment: GameEnvironment!
    var onQuit: (() -> Void)?
    
    private var playerItems: [PlayerItem] = []
    private var handItems: [HandItem] = []
    private var messages: [String] = []
    private var endTurnMoves: [GMove] = []
    private var otherMoves: [GMove] = []
    private var state: StateProtocol!
    
    private lazy var analyticsManager: AnalyticsManager = Resolver.resolve()
    private lazy var preferences: UserPreferencesProtocol = Resolver.resolve()
    
    private lazy var playerAdapter: PlayersAdapterProtocol = PlayersAdapter()
    private lazy var messageAdapter: MessageAdapterProtocol = MessageAdapter()
    private lazy var instructionBuilder: InstructionBuilderProtocol = InstructionBuilder()
    
    private lazy var handAdapter: HandAdapterProtocol? = {
        guard let playerId = environment.controlledId else {
            return nil
        }
        return HandAdapter(playerId: playerId) 
    }()
    
    private lazy var moveSoundPlayer: SFXPlayerProtocol? = {
        preferences.enableSound ? SFXPlayer() : nil
    }()
    
    private var updateAnimator: UpdateAnimatorProtocol?
    
    private let disposeBag = DisposeBag()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = playersCollectionView.collectionViewLayout as? GameCollectionViewLayout
        layout?.delegate = self
        
        if let users = environment.gameUsers {
            playerAdapter.setUsers(users)
        }
        
        environment.database.state(observedBy: environment.controlledId).subscribe(onNext: { [weak self] state in
            self?.processState(state)
        })
        .disposed(by: disposeBag)
        
        environment.database.event.subscribe(onNext: { [weak self] update in
            self?.processEvent(update)
        })
        .disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showRoles()
        
        // Wait until collectionView loaded to initialize updateAnimator
        playersCollectionView.performBatchUpdates(nil) { [self] _ in
            updateAnimator = UpdateAnimator(viewController: self,
                                            cardPositions: buildCardPositions(),
                                            cardSize: buildCardSize(),
                                            updateDelay: preferences.updateDelay)
        }
    }
    
    // MARK: IBAction
    
    @IBAction private func refreshButtonTapped(_ sender: Any) {
        environment.engine.refresh()
    }
    
    @IBAction private func menuButtonTapped(_ sender: Any) {
        onQuit?()
    }
    
    @IBAction private func endTurnTapped(_ sender: Any) {
        playMove(among: endTurnMoves)
    }
    
    @IBAction private func otherMovesTapped(_ sender: Any) {
        playMove(among: otherMoves)
    }
}

private extension GameViewController {
    
    func processState(_ state: StateProtocol) {
        self.state = state
        
        playerItems = playerAdapter.buildItems(state: state, scores: [:])
        playersCollectionView.reloadData()
        
        discardImageView.image = state.topDiscardImage
        deckCountLabel.text = "[] \(state.deck.count)"
        
        titleLabel.text = instructionBuilder.buildInstruction(state: state, for: environment.controlledId)
    }
    
    func processEvent(_ event: GEvent) {
        switch event {
        case let .activate(moves):
            processValidMoves(moves)
            
        case let .play(move):
            processExecutedMove(move)
            
        case let .gameover(winner):
            showGameOver(winner)
            analyticsManager.tagEventGameOver(state)
            
        default:
            break
        }
        
        updateAnimator?.animate(on: event, in: state)
        moveSoundPlayer?.playSound(on: event)
    }
    
    func processExecutedMove(_ move: GMove) {
        messages.append(messageAdapter.description(for: move))
        messageTableView.reloadDataScrollingAtBottom()
    }
    
    func processValidMoves(_ moves: [GMove]) {
        let moves = moves.filter { $0.actor == environment.controlledId }
        
        if let items = handAdapter?.buildItems(validMoves: moves, state: state) {
            handItems = items
            handCollectionView.reloadData()
        }
        
        if let hit = state.hits.first,
           !moves.isEmpty {
            let alert = UIAlertController(title: hit.abilities.joined(separator: ","), 
                                          choices: moves.map { String(describing: $0) },
                                          cancelable: false,
                                          completion: { [weak self] index in 
                                            self?.environment.engine.execute(moves[index])
                                          })
            present(alert, animated: true)
        }
        
        endTurnMoves = moves.filter { $0.ability == "endTurn" }
        endTurnButton.isEnabled = !endTurnMoves.isEmpty
        
        otherMoves = moves.filter { $0.card == nil && $0.ability != "endTurn" }
        otherMovesButton.isEnabled = !otherMoves.isEmpty
    }
    
    func showGameOver(_ winner: Role) {
        let alert = UIAlertController(title: "Game Over",
                                      message: "\(winner.rawValue) wins",
                                      closeAction: "Close", 
                                      completion: { [weak self] in 
                                        self?.onQuit?()
                                      })
        present(alert, animated: true)
    }
    
    func buildCardPositions() -> [CardPlace: CGPoint] {
        var result: [CardPlace: CGPoint] = [:]
        
        guard let discardCenter = discardImageView.superview?.convert(discardImageView.center, to: view),
            let deckCenter = deckImageView.superview?.convert(deckImageView.center, to: view)  else {
                fatalError("Illegal state")
        }
        
        result[.deck] = deckCenter
        result[.discard] = discardCenter
        
        let playerIds = state.initialOrder
        for (index, playerId) in playerIds.enumerated() {
            guard let cell = playersCollectionView.cellForItem(at: IndexPath(row: index, section: 0)),
                let cellCenter = cell.superview?.convert(cell.center, to: view) else {
                    fatalError("Illegal state")
            }
            
            let handPosition = cellCenter
            let inPlayPosition = cellCenter.applying(CGAffineTransform(translationX: cell.bounds.size.height / 2, y: 0))
            
            result[.hand(playerId)] = handPosition
            result[.inPlay(playerId)] = inPlayPosition
        }
        
        return result
    }
    
    func buildCardSize() -> CGSize {
        discardImageView.bounds.size
    }
    
    func showRoles() {
        let roles = GSetup().roles(for: state.players.count)
        let rolesWithCount: [String] = Role.allCases.compactMap { role in
            guard let count = roles.filterOrNil({ $0 == role })?.count else {
                return nil
            }
            return "\(count) \(role.rawValue)"
        }
        let message = rolesWithCount.joined(separator: "\n")
        let alert = UIAlertController(title: "Roles", message: message, closeAction: "Close")
        present(alert, animated: true)
    }
    
    func playMove(among moves: [GMove]) {
        let alert = UIAlertController(title: "Select move",
                                      choices: moves.map { String(describing: $0) },
                                      completion: { [weak self] index in
                                        self?.environment.engine.execute(moves[index])
                                      })
        present(alert, animated: true)
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
            return handCollectionViewNumberOfItems()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == playersCollectionView {
            return playersCollectionView(collectionView, cellForItemAt: indexPath)
        } else {
            return handCollectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    private func playersCollectionViewNumberOfItems() -> Int {
        playerItems.count
    }
    
    private func handCollectionViewNumberOfItems() -> Int {
        handItems.count
    }
    
    private func playersCollectionView(_ collectionView: UICollectionView,
                                       cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: PlayerCell.self, for: indexPath)
        cell.update(with: playerItems[indexPath.row])
        return cell
    }
    
    private func handCollectionView(_ collectionView: UICollectionView,
                                    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: HandCell.self, for: indexPath)
        cell.update(with: handItems[indexPath.row])
        return cell
    }
}

extension GameViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == playersCollectionView {
            playersCollectionViewDidSelectItem(at: indexPath)
        } else {
            handCollectionViewDidSelectItem(at: indexPath)
        }
    }
    
    private func playersCollectionViewDidSelectItem(at indexPath: IndexPath) {
        let player = playerItems[indexPath.row].player
        let alert = UIAlertController(title: player.name.uppercased(),
                                      message: player.desc,
                                      closeAction: "Close")
        present(alert, animated: true)
        analyticsManager.tageEventPlayerDescriptor(player)
    }
    
    private func handCollectionViewDidSelectItem(at indexPath: IndexPath) {
        playMove(among: handItems[indexPath.row].moves)
    }
}

extension GameViewController: GameCollectionViewLayoutDelegate {
    
    func numberOfItemsForGameCollectionViewLayout(layout: GameCollectionViewLayout) -> Int {
        state.players.count
    }
}

extension StateProtocol {
    
    var topDiscardImage: UIImage? {
        guard let topDiscard = discard.first else {
            return UIImage(color: .gold)
        }
        
        return UIImage(named: topDiscard.name)
    }
}
