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
    
    private var state: StateProtocol!
    private var playerItems: [PlayerItem] = []
    private var handCards: [CardProtocol] = []
    private var segmentedMoves: [String: [GMove]] = [:]
    private var messages: [String] = []
    
    private lazy var analyticsManager: AnalyticsManager = Resolver.resolve()
    private lazy var preferences: UserPreferencesProtocol = Resolver.resolve()
    private lazy var resourceLoader: ResourcesLoaderProtocol = Resolver.resolve()
    private lazy var eventMatcher: UIEventMatcherProtocol = Resolver.resolve()
    
    private lazy var playerAdapter: PlayersAdapterProtocol = PlayersAdapter()
    private lazy var instructionBuilder: InstructionBuilderProtocol = InstructionBuilder()
    private lazy var moveSegmenter: MoveSegmenterProtocol = MoveSegmenter()
    
    private lazy var inputHandler: InputHandlerProtocol = InputHandler(selector: MoveSelector(), viewController: self)
    
    private lazy var animationRenderer: AnimationRendererProtocol = {
        AnimationRenderer(viewController: self,
                          delay: preferences.updateDelay, 
                          cardPositions: buildCardPositions(),
                          cardSize: discardImageView.bounds.size,
                          cardBackImage: #imageLiteral(resourceName: "01_back"))
    }()
    
    private let sfxPlayer: SFXPlayerProtocol = SFXPlayer()
    
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
    }
    
    // MARK: IBAction
    
    @IBAction private func refreshButtonTapped(_ sender: Any) {
        environment.engine.refresh()
    }
    
    @IBAction private func menuButtonTapped(_ sender: Any) {
        onQuit?()
    }
    
    @IBAction private func endTurnTapped(_ sender: Any) {
        guard let moves = segmentedMoves["endTurn"] else {
            return
        }
        
        inputHandler.selectMove(among: moves, context: nil, cancelable: true) { [weak self] move in
            self?.environment.engine.execute(move)
        }
    }
    
    @IBAction private func otherMovesTapped(_ sender: Any) {
        guard let moves = segmentedMoves["*"] else {
            return
        }
        
        inputHandler.selectMove(among: moves, context: nil, cancelable: true) { [weak self] move in
            self?.environment.engine.execute(move)
        }
    }
}

private extension GameViewController {
    
    func processState(_ state: StateProtocol) {
        self.state = state
        
        playerItems = playerAdapter.buildItems(state: state)
        playersCollectionView.reloadData()
        
        if let controlledId = environment.controlledId,
           let player = state.players[controlledId] {
            handCards = player.hand
            handCollectionView.reloadData()
        }
        
        discardImageView.image = state.topDiscardImage
        deckCountLabel.text = "[] \(state.deck.count)"
        
        titleLabel.text = instructionBuilder.buildInstruction(state: state, for: environment.controlledId)
    }
    
    func processEvent(_ event: GEvent) {
        switch event {
        case let .activate(moves):
            let moves = moves.filter { $0.actor == environment.controlledId }
            processMoves(moves)
            
        case let .gameover(winner):
            showGameOver(winner)
            analyticsManager.tagEventGameOver(state)
            
        default:
            break
        }
        
        messages.append("\(eventMatcher.emoji(event) ?? "") \(event)")
        messageTableView.reloadDataScrollingAtBottom()
        
        #if DEBUG
        print("\(eventMatcher.emoji(event) ?? "") \(event)")
        #endif
        
        if let gfx = eventMatcher.animation(on: event, in: state) {
            animationRenderer.execute(gfx, duration: eventMatcher.waitDuration(event))
        }
        
        if let sfx = eventMatcher.sfx(on: event) {
            sfxPlayer.playSound(named: sfx)
        }
    }
    
    func processMoves(_ moves: [GMove]) {
        segmentedMoves = moveSegmenter.segment(moves)
        
        handCollectionView.reloadData()
        endTurnButton.isEnabled = segmentedMoves["endTurn"] != nil
        otherMovesButton.isEnabled = segmentedMoves["*"] != nil
        
        // <RULE> Force select reaction moves
        if !moves.isEmpty,
           let hit = state.hits.first {
            inputHandler.selectMove(among: moves, context: hit.name, cancelable: false) { [weak self] move in
                self?.environment.engine.execute(move)
            }
        }
        // </RULE> 
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
    
    func buildCardPositions() -> [CardArea: CGPoint] {
        var result: [CardArea: CGPoint] = [:]
        
        guard let discardCenter = discardImageView.superview?.convert(discardImageView.center, to: view),
              let deckCenter = deckImageView.superview?.convert(deckImageView.center, to: view)  else {
            fatalError("Illegal state")
        }
        
        result[.deck] = deckCenter
        result[.store] = deckCenter
        result[.discard] = discardCenter
        
        let playerIds = state.initialOrder
        for (index, playerId) in playerIds.enumerated() {
            guard let attribute = playersCollectionView.collectionViewLayout
                    .layoutAttributesForItem(at: IndexPath(row: index, section: 0)) else {
                fatalError("Illegal state")
            }
            let cellCenter = playersCollectionView.convert(attribute.center, to: view)
            let handPosition = cellCenter
            let inPlayPosition = cellCenter.applying(CGAffineTransform(translationX: attribute.bounds.size.height / 2, y: 0))
            result[.hand(playerId)] = handPosition
            result[.inPlay(playerId)] = inPlayPosition
        }
        
        return result
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
        handCards.count
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
        let card = handCards[indexPath.row]
        let active = segmentedMoves[card.identifier] != nil
        cell.update(with: card, active: active)
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
        guard let moves = segmentedMoves[handCards[indexPath.row].identifier] else {
            return
        }
        
        inputHandler.selectMove(among: moves, context: nil, cancelable: true) { [weak self] move in
            self?.environment.engine.execute(move)
        }
    }
}

extension GameViewController: GameCollectionViewLayoutDelegate {
    
    func numberOfItemsForGameCollectionViewLayout(layout: GameCollectionViewLayout) -> Int {
        state.players.count
    }
}

private extension StateProtocol {
    
    var topDiscardImage: UIImage? {
        guard let topDiscard = discard.first else {
            return UIImage(color: .gold)
        }
        
        return UIImage(named: topDiscard.name)
    }
}
