//
//  GameViewController.swift
//  WildWest
//
//  Created by Hugues Stephano Telolahy on 24/01/2020.
//  Copyright © 2020 creativeGames. All rights reserved.
//
// swiftlint:disable type_body_length

import UIKit
import RxSwift

class GameViewController: UIViewController, Subscribable {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var endTurnButton: UIButton!
    @IBOutlet private weak var otherMovesButton: UIButton!
    @IBOutlet private weak var playersCollectionView: UICollectionView!
    @IBOutlet private weak var actionsCollectionView: UICollectionView!
    @IBOutlet private weak var messageTableView: UITableView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var discardImageView: UIImageView!
    @IBOutlet private weak var deckImageView: UIImageView!
    @IBOutlet private weak var deckCountLabel: UILabel!
    
    // MARK: Properties
    
    var engine: GameEngineProtocol?
    var aiAgents: [AIPlayerAgentProtocol]?
    var controlledPlayerId: String?
    
    private var playerItems: [PlayerItem] = []
    private var actionItems: [ActionItem] = []
    private var messages: [String] = []
    private var endTurnMoves: [GameMove] = []
    private var otherMoves: [GameMove] = []
    private var latestState: GameStateProtocol?
    private var latestMove: GameMove?
    private var moveSoundPlayer: MoveSoundPlayerProtocol?
    private var reactionMoveSelector: ReactionMoveSelectorProtocol?
    
    private lazy var statsBuilder: StatsBuilderProtocol = {
        guard let sheriff = engine?.subjects.allPlayers.first(where: { $0.role == .sheriff }) else {
            fatalError("Illegal state")
        }
        
        return StatsBuilder(sheriffId: sheriff.identifier, classifier: MoveClassifier())
    }()
    
    private lazy var playerAdapter = PlayersAdapter()
    private lazy var actionsAdapter = ActionsAdapter(playerId: controlledPlayerId)
    private lazy var moveDescriptor = MoveDescriptor()
    private lazy var instructionBuilder = InstructionBuilder()
    private lazy var playMoveSelector = PlayMoveSelector(viewController: self)
    
    private lazy var playerDescriptor = PlayerDescriptor(viewController: self)
    
    private lazy var updateAnimator = UpdateAnimator(viewController: self,
                                                     cardPositions: buildCardPositions(),
                                                     cardSize: buildCardSize())
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserPreferences.shared.enableSound {
            moveSoundPlayer = MoveSoundPlayer()
        }
        
        if UserPreferences.shared.assistedMode {
            reactionMoveSelector = AssistedReactionMoveSelector(ai: RandomAI())
        } else {
            reactionMoveSelector = ReactionMoveSelector(viewController: self)
        }
        
        let layout = playersCollectionView.collectionViewLayout as? GameCollectionViewLayout
        layout?.delegate = self
        
        guard let engine = self.engine else {
            return
        }
        
        sub(engine.subjects.state(observedBy: controlledPlayerId).subscribe(onNext: { [weak self] state in
            self?.processState(state)
        }))
        
        sub(engine.subjects.executedMove().subscribe(onNext: { [weak self] move in
            self?.processExecutedMove(move)
        }))
        
        sub(engine.subjects.executedUpdate().subscribe(onNext: { [weak self] update in
            self?.processExecutedUpdate(update)
        }))
        
        if let controlledPlayerId = self.controlledPlayerId {
            sub(engine.subjects.validMoves(for: controlledPlayerId).subscribe(onNext: { [weak self] moves in
                self?.processValidMoves(moves)
            }))
        }
        
        aiAgents?.forEach { $0.observeState() }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        engine?.startGame()
    }
    
    // MARK: IBAction
    
    @IBAction private func menuButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction private func endTurnTapped(_ sender: Any) {
        playMoveSelector.selectMove(within: endTurnMoves) { [weak self] move in
            self?.engine?.execute(move)
        }
    }
    
    @IBAction private func otherMovesTapped(_ sender: Any) {
        playMoveSelector.selectMove(within: otherMoves) { [weak self] move in
            self?.engine?.execute(move)
        }
    }
    
}

private extension GameViewController {
    
    func processState(_ state: GameStateProtocol) {
        latestState = state
        
        playerItems = playerAdapter.buildItems(state: state, latestMove: latestMove, scores: statsBuilder.scores)
        playersCollectionView.reloadData()
        
        actionItems = actionsAdapter.buildActions(state: state)
        actionsCollectionView.reloadData()
        
        discardImageView.image = state.topDiscardImage
        deckCountLabel.text = "[] \(state.deck.count)"
        
        titleLabel.text = instructionBuilder.buildInstruction(state: state, for: controlledPlayerId)
        
        if let outcome = state.outcome {
            showGameOver(outcome: outcome)
            AnalyticsManager.shared.tagEventGameOver(state)
        }
    }
    
    func processExecutedMove(_ move: GameMove) {
        latestMove = move
        
        messages.append(moveDescriptor.description(for: move))
        messageTableView.reloadDataScrollingAtBottom()
        
        moveSoundPlayer?.playSound(for: move)
        
        statsBuilder.updateOnExecuting(move)
    }
    
    func processExecutedUpdate(_ update: GameUpdate) {
        guard let state = latestState else {
            return
        }
        
        updateAnimator.animate(update, in: state)
    }
    
    func processValidMoves(_ moves: [GameMove]) {
        guard let state = latestState else {
            return
        }
        
        actionItems = actionsAdapter.buildActions(validMoves: moves)
        actionsCollectionView.reloadData()
        
        if state.challenge != nil,
            !moves.isEmpty {
            reactionMoveSelector?.selectMove(within: moves, state: state) { [weak self] move in
                self?.engine?.execute(move)
            }
        }
        
        endTurnMoves = moves.filter({ $0.name == .endTurn })
        endTurnButton.isEnabled = !endTurnMoves.isEmpty
        
        let ownedCardIds: [String] = state.player(controlledPlayerId)?.hand.map { $0.identifier } ?? []
        otherMoves = moves.filter({ !ownedCardIds.contains($0.cardId ?? "") && $0.name != .endTurn })
        otherMovesButton.isEnabled = !otherMoves.isEmpty
    }
    
    func showGameOver(outcome: GameOutcome) {
        let alertController = UIAlertController(title: "Game Over",
                                                message: outcome.rawValue,
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        
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
            self?.engine?.execute(move)
        }
    }
}

extension GameViewController: GameCollectionViewLayoutDelegate {
    
    func numberOfItemsForGameCollectionViewLayout(layout: GameCollectionViewLayout) -> Int {
        guard let engine = self.engine else {
            return 0
        }
        
        return engine.subjects.allPlayers.count
    }
}

private extension GameViewController {
    
    func buildCardPositions() -> [CardPlace: CGPoint] {
        guard let engine = self.engine else {
            return [:]
        }
        
        var result: [CardPlace: CGPoint] = [:]
        
        guard let discardCenter = discardImageView.superview?.convert(discardImageView.center, to: view),
            let deckCenter = deckImageView.superview?.convert(deckImageView.center, to: view)  else {
                fatalError("Illegal state")
        }
        
        result[.deck] = deckCenter
        result[.discard] = discardCenter
        
        let playerIds = engine.subjects.allPlayers.map { $0.identifier }
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
}
