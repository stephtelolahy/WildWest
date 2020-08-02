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

class GameViewController: UIViewController, Subscribable {
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var startButton: UIButton!
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
    
    private var engine: GameEngineProtocol {
        environment.engine
    }
    
    private var subjects: GameSubjectsProtocol {
        environment.subjects
    }
    
    private var controlledPlayerId: String? {
        environment.controlledId
    }
    
    private var playerItems: [PlayerItem] = []
    private var handItems: [HandItem] = []
    private var messages: [String] = []
    private var endTurnMoves: [GameMove] = []
    private var otherMoves: [GameMove] = []
    private var latestState: GameStateProtocol?
    private var latestMove: GameMove?
    
    private lazy var analyticsManager: AnalyticsManager = Resolver.resolve()
    private lazy var preferences: UserPreferencesProtocol = Resolver.resolve()
    
    private lazy var statsBuilder: StatsBuilderProtocol = {
        StatsBuilder(sheriffId: subjects.sheriffId, classifier: MoveClassifier())
    }()
    
    private lazy var playerAdapter: PlayersAdapterProtocol = PlayersAdapter()
    private lazy var handAdapter: HandAdapterProtocol = HandAdapter(playerId: controlledPlayerId)
    private lazy var moveDescriptor: MoveDescriptorProtocol = MoveDescriptor()
    private lazy var instructionBuilder: InstructionBuilderProtocol = InstructionBuilder()
    private lazy var playMoveSelector: PlayMoveSelectorProtocol = PlayMoveSelector(viewController: self)
    private lazy var updateAnimator: UpdateAnimatorProtocol = {
        UpdateAnimator(viewController: self,
                       cardPositions: buildCardPositions(),
                       cardSize: buildCardSize(),
                       updateDelay: preferences.updateDelay)
    }()
    
    private lazy var moveSoundPlayer: MoveSoundPlayerProtocol? = {
        preferences.enableSound ? MoveSoundPlayer() : nil
    }()
    
    private lazy var reactionMoveSelector: ReactionMoveSelectorProtocol? = {
        if preferences.assistedMode {
            return AssistedReactionMoveSelector(ai: RandomAI())
        } else {
            return ReactionMoveSelector(viewController: self)
        }
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = playersCollectionView.collectionViewLayout as? GameCollectionViewLayout
        layout?.delegate = self
        
        if let users = environment.gameUsers {
            playerAdapter.setUsers(users)
        }
        
        sub(subjects.state(observedBy: controlledPlayerId).subscribe(onNext: { [weak self] state in
            self?.processState(state)
            }, onError: { [weak self] error in
                self?.presentAlert(title: "Error", message: error.localizedDescription)
        }))
        
        sub(subjects.executedMove().subscribe(onNext: { [weak self] move in
            self?.processExecutedMove(move)
        }))
        
        sub(subjects.executedUpdate().subscribe(onNext: { [weak self] update in
            self?.processExecutedUpdate(update)
        }))
        
        if let controlledPlayerId = self.controlledPlayerId {
            sub(subjects.validMoves(for: controlledPlayerId).subscribe(onNext: { [weak self] moves in
                self?.processValidMoves(moves)
            }))
        }
        
        startButton.isEnabled = playingSheriff()
        
        showRoles()
    }
    
    // MARK: IBAction
    
    @IBAction private func startButtonTapped(_ sender: Any) {
        engine.start()
        startButton.isEnabled = false
    }
    
    @IBAction private func menuButtonTapped(_ sender: Any) {
        onQuit?()
    }
    
    @IBAction private func endTurnTapped(_ sender: Any) {
        playMoveSelector.selectMove(within: endTurnMoves) { [weak self] move in
            self?.engine.execute(move)
        }
    }
    
    @IBAction private func otherMovesTapped(_ sender: Any) {
        playMoveSelector.selectMove(within: otherMoves) { [weak self] move in
            self?.engine.execute(move)
        }
    }
}

private extension GameViewController {
    
    func processState(_ state: GameStateProtocol) {
        #if DEBUG
        print("!! state")
        #endif
        latestState = state
        
        playerItems = playerAdapter.buildItems(state: state, latestMove: latestMove, scores: statsBuilder.scores)
        playersCollectionView.reloadData()
        
        handItems = handAdapter.buildItems(validMoves: [], state: state)
        handCollectionView.reloadData()
        
        discardImageView.image = state.topDiscardImage
        deckCountLabel.text = "[] \(state.deck.count)"
        
        titleLabel.text = instructionBuilder.buildInstruction(state: state, for: controlledPlayerId)
        
        if let outcome = state.outcome {
            showGameOver(outcome: outcome)
            analyticsManager.tagEventGameOver(state)
        }
    }
    
    func processExecutedMove(_ move: GameMove) {
        #if DEBUG
        print("\n*** \(String(describing: move)) ***")
        #endif
        
        latestMove = move
        
        messages.append(moveDescriptor.description(for: move))
        messageTableView.reloadDataScrollingAtBottom()
        
        moveSoundPlayer?.playSound(for: move)
        
        statsBuilder.updateScores(move)
    }
    
    func processExecutedUpdate(_ update: GameUpdate) {
        #if DEBUG
        print("> \(String(describing: update))")
        #endif
        
        guard let state = latestState else {
            return
        }
        
        updateAnimator.animate(update, in: state)
    }
    
    func processValidMoves(_ moves: [GameMove]) {
        guard let state = latestState else {
            return
        }
        
        handItems = handAdapter.buildItems(validMoves: moves, state: latestState)
        handCollectionView.reloadData()
        
        if state.challenge != nil,
            !moves.isEmpty {
            reactionMoveSelector?.selectMove(within: moves, state: state) { [weak self] move in
                self?.engine.execute(move)
            }
        }
        
        endTurnMoves = moves.filter { $0.name == .endTurn }
        endTurnButton.isEnabled = !endTurnMoves.isEmpty
        
        let ownedCardIds: [String] = state.player(controlledPlayerId)?.hand.map { $0.identifier } ?? []
        otherMoves = moves.filter { !ownedCardIds.contains($0.cardId ?? "") && $0.name != .endTurn }
        otherMovesButton.isEnabled = !otherMoves.isEmpty
    }
    
    func showGameOver(outcome: GameOutcome) {
        presentAlert(title: "Game Over", message: outcome.rawValue) { [weak self] in
            self?.onQuit?()
        }
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
        let playerDescriptor = PlayerDescriptor(player: player)
        present(playerDescriptor, animated: true)
        analyticsManager.tageEventPlayerDescriptor(player)
    }
    
    private func handCollectionViewDidSelectItem(at indexPath: IndexPath) {
        let moves = handItems[indexPath.row].moves
        playMoveSelector.selectMove(within: moves) { [weak self] move in
            self?.engine.execute(move)
        }
    }
}

extension GameViewController: GameCollectionViewLayoutDelegate {
    
    func numberOfItemsForGameCollectionViewLayout(layout: GameCollectionViewLayout) -> Int {
        subjects.playerIds(observedBy: controlledPlayerId).count
    }
}

private extension GameViewController {
    
    func buildCardPositions() -> [CardPlace: CGPoint] {
        var result: [CardPlace: CGPoint] = [:]
        
        guard let discardCenter = discardImageView.superview?.convert(discardImageView.center, to: view),
            let deckCenter = deckImageView.superview?.convert(deckImageView.center, to: view)  else {
                fatalError("Illegal state")
        }
        
        result[.deck] = deckCenter
        result[.discard] = discardCenter
        
        let playerIds = subjects.playerIds(observedBy: controlledPlayerId)
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
    
    func playingSheriff() -> Bool {
        var playerIds: [String] = []
        
        if let controllerId = controlledPlayerId {
            playerIds.append(controllerId)
        }
        
        if let aiAgents = environment.aiAgents {
            playerIds.append(contentsOf: aiAgents.map { $0.playerId })
        }
        
        return playerIds.contains(where: { latestState?.player($0)?.role == .sheriff })
    }
    
    func showRoles() {
        let playersCount = subjects.playerIds(observedBy: controlledPlayerId).count
        let roles = GameSetup().roles(for: playersCount)
        let rolesWithCount: [String] = Role.allCases.compactMap { role in
            guard let count = roles.filterOrNil({ $0 == role })?.count else {
                return nil
            }
            return "\(count) \(role.rawValue)"
        }
        let message = rolesWithCount.joined(separator: "\n")
        presentAlert(title: "Roles", message: message)
    }
}
